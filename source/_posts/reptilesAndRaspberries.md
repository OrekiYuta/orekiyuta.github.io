---
title: Reptiles and Raspberries
date: 2021-01-08 21:49:18
tags: [Python,Selenium,Chromium,Mariadb,MySQL,Flask,BeautifulSoup,Echarts,Gunicorn,JavaScript,Crontab,RaspberryPi,Linux,Nginx,ChromeDriver,ARM]
---

## 分析接口数据结构
- 找到数据的接口信息之后，请求获取数据并逐层分析数据结构
- 然后提取需要的数据
- 最后封装成方法
```py
def get_tencent_virus_data():
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit'
                      '/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safar'
                      'i/537.36',
    }

    # https://news.qq.com/zt2020/page/feiyan.htm#/
    url = "https://view.inews.qq.com/g2/getOnsInfo?name=disease_h5"
    res = requests.get(url, headers=headers)
    res.encoding = "utf-8"
    getSource = json.loads(res.text)
    sourceData = json.loads(getSource["data"])

    lastUpdateTime = sourceData["lastUpdateTime"]  # 最后更新时间
    chinaTotal = sourceData["chinaTotal"]  # 总情况
    chinaAdd = sourceData["chinaAdd"]  # 总确诊
    areaTree = sourceData["areaTree"]  # 国家

    # 国家列表,中国
    name = areaTree[0]["name"]  # 中国
    today = areaTree[0]["today"]  # 今天新增确诊
    total = areaTree[0]["total"]  # 今日总情况
    provinces = areaTree[0]["children"]  # 34个省份

    # print(name)
    # print(today)
    # print(total)

    # 今日确诊，目前确诊，总确诊，总死亡数，总死亡概率，总康复数，总康复概率
    daily_data = [name, today["confirm"], total["nowConfirm"], total["confirm"], total["dead"], total["deadRate"],
                  total["heal"], total["healRate"]]

    today_details = []
    for province in provinces:
        # print(province["name"])  # 省名
        # print(province["today"])
        # print(province["total"])
        province_name_ = province["name"]

        # 省所属城市
        for city in province["children"]:
            city_name_ = city["name"]
            city_today_confirm_ = city["today"]["confirm"]  # 该城市今日确诊
            city_total_confirm_ = city["total"]["confirm"]  # 该城市总确诊
            city_total_heal_ = city["total"]["heal"]  # 该城市总康复
            city_total_heal_rate_ = city["total"]["healRate"]  # 该城市总康复概率
            city_total_dead_ = city["total"]["dead"]  # 该城市总死亡
            city_total_dead_rate_ = city["total"]["deadRate"]  # 该城市总死亡概率
            today_details.append([lastUpdateTime, province_name_, city_name_, city_today_confirm_,
                                  city_total_confirm_, city_total_heal_, city_total_heal_rate_,
                                  city_total_dead_, city_total_dead_rate_
                                  ])

    return today_details, daily_data
```
<!-- more -->

## 数据库连接
- 这里主要在于建立数据库连接，并取得游标去操作数据
- 连接数据库操作完毕之后需要及时关闭连接
```py
def mariadb_conn():
    try:
        conn = mariadb.connect(
            user="root",
            password="raspberry",
            host="192.168.137.47",
            port=3306,
            database="virus"
        )
        cursor = conn.cursor()
        return conn, cursor

    except mariadb.Error as e:
        print(f"Error connecting to MariaDB Platform: {e}")
        sys.exit(1)


def mariadb_conn_close(conn, cursor):
    if cursor:
        cursor.close()
    if conn:
        conn.close()
```

## 获取数据并持久化
- 这里需要注意的是游标的操作 `cursor.execute()`
- 如果是查询语句的话，游标执行之后就能得到返回的数据
- 其他的语句需要提交事务`conn.commit()`才能得到返回的数据
```py
# 更新每日的详情数据
def update_virus_data():
    cursor = None
    conn = None
    try:
        virus_data = get_tencent_virus_data()[0]
        # conn, cursor = mariadb_conn("root", "raspberry", "192.168.137.165", 3306, "virus")
        conn, cursor = mariadb_conn()
        setDataTime = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
        sql_insert_data = "insert into tencent_virus_data(lastUpdateTime,province_name_," \
                          "city_name_,city_today_confirm_,city_total_confirm_," \
                          "city_total_heal_,city_total_heal_rate_," \
                          "city_total_dead_,city_total_dead_rate_," \
                          "setDataTime"") values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"

        # 取数据库最后一个记录的时间字段
        sql_lastTime = "select lastUpdateTime from tencent_virus_data order by id desc limit 1"
        cursor.execute(sql_lastTime)
        lastUpdateTime = cursor.fetchone()

        # 第一次初始化数据
        if lastUpdateTime is None:
            print(f"{time.asctime()}    --->    滴滴！初始化最初的数据！")
            for item in virus_data:
                item.append(setDataTime)
                print(item)
                cursor.execute(sql_insert_data, item)
            conn.commit()
            print(f"{time.asctime()}    --->    嗒嗒！初始化数据完毕！")

        # 非第一次更新数据
        else:
            # virus_data[0][0] 拿第一条数据的时间字段,因为每条数据时间都是一样的
            dataNowTime = datetime.strptime(virus_data[0][0], '%Y-%m-%d %H:%M:%S')
            # 数据库最新记录时间 与 当前请求的数据时间对比，判断是否更新数据
            if dataNowTime > lastUpdateTime[0]:
                print(f"{time.asctime()}    --->    滴滴！开始更新最新数据！")
                for item in virus_data:
                    item.append(setDataTime)
                    cursor.execute(sql_insert_data, item)
                conn.commit()
                print(f"{time.asctime()}    --->    嗒嗒！更新最新数据完毕！")
            else:
                print(f"{time.asctime()}    --->    嗯！已是最新数据！")

    except:
        traceback.print_exc()
    finally:
        mariadb_conn_close(conn, cursor)
```

## 从页面抓取数据
### 一般的页面，直接请求解析获取即可
```py
def baidu_hotPoint():
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit'
                      '/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safar'
                      'i/537.36',
    }
    url = "http://top.baidu.com/buzz?b=1&fr=topindex"

    res = requests.get(url, headers=headers)
    res.encoding = "gb2312"
    html = res.text
    soup = BeautifulSoup(html, "lxml")
    titles = soup.find_all(name="a", attrs={"class": "list-title"})
    content = [title.text for title in titles]

    return content
```
### 如果页面用的是 JS 加载的话，可以使用 selenium 模拟人工获取
- 在这里需要浏览器和浏览器驱动配合
- 获得和 chrome 浏览器版本一致的 chromedriver 驱动
- 👉 [https://npm.taobao.org/mirrors/chromedriver/](https://npm.taobao.org/mirrors/chromedriver/)
```py
def sogou_hotSearch():
    headers = 'user-agent="MQQBrowser/26 Mozilla/5.0 (Linux; U; Android 2.3.7; zh-cn; MB200 Build/GRJ22; ' \
              'CyanogenMod-7) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1" '

    url = "https://sa.sogou.com/new-weball/page/sgs/epidemic?type_page=VR"

    from selenium.webdriver.chrome.options import Options

    options = ChromeOptions()
    options.add_argument(headers)
    options.add_argument("--headless")  # 隐藏浏览器
    options.add_argument("--no-sandbox")  # linux 需要禁用这个
    options.add_argument("--disable-gpu")
    options.add_argument('blink-settings=imagesEnabled=false')  # 不加载图片资源
    chrome = Chrome(executable_path="./chromedriver.exe", options=options)  # 路径加载驱动
    # chrome = Chrome(options=options)
    chrome.get(url)
    el_lis = chrome.find_elements_by_xpath('//*[@id="no_active_pane"]/div/div/div[2]/ul/li')
    content = [el_li.text for el_li in el_lis]
    chrome.close()

    return content
```

## 建立 Web 服务

### 数据交互
- 这里使用 flask 建立简单的请求服务
- 在服务端返回页面需要用到 render_template
```py
from flask import render_template

@app.route('/', methods=["get", "post"])
def hello_world():
    return render_template("index.html")
```
- 接着在页面发送 ajax 请求对应的路由即可

### 建立工具类来处理数据
- 在项目根路径建一个 xxx.py 来专门处理数据
    - 数据库连接方法
    - 查询类方法
    - 每个数据接口方法
```py
def get_time():
    time_str = time.strftime("%Y{}%m{}%d{} %X")
    return time_str.format("年", "月", "日")


def mariadb_conn():
    try:
        conn = mariadb.connect(
            user="root",
            password="raspberry",
            host="192.168.137.47",
            port=3306,
            database="virus"
        )
        cursor = conn.cursor()
        return conn, cursor

    except mariadb.Error as e:
        print(f"Error connecting to MariaDB Platform: {e}")
        sys.exit(1)


def mariadb_conn_close(conn, cursor):
    if cursor:
        cursor.close()
    if conn:
        conn.close()


def query(sql, *args):
    """
    :param sql:
    :param args
    :return 返回查询结果 ((),())
    """
    conn, cursor = mariadb_conn()
    cursor.execute(sql, args)
    res = cursor.fetchall()
    mariadb_conn_close(conn, cursor)

    return res


def get_daily_data():
    sql = "select today_confirm,total_nowConfirm," \
          "total_confirm,total_dead,total_deadRate," \
          "total_heal,total_healRate from daily_data " \
          "where setDataTime=(select setDataTime from daily_data " \
          "order by setDataTime desc limit 1)"
    res = query(sql)
    return res[0]


# 地图整体数据
def get_area_data():
    sql = "select province_name_,sum(city_total_confirm_) " \
          "from tencent_virus_data where lastUpdateTime=(" \
          "select lastUpdateTime from tencent_virus_data " \
          "order by lastUpdateTime desc limit 1) " \
          "group by province_name_"
    res = query(sql)
    return res


# 总趋势最近十天
def get_GeneralTrend_data():
    sql = "select today_confirm,total_nowConfirm,total_confirm," \
          "total_dead,total_heal,setDataTime from daily_data " \
          "order by  id desc limit 10"
    res = query(sql)
    return res
# get_GeneralTrend_data()[1:] # 从第二条数据开始取

# 今日有新增确诊的省市
def get_todayNewConfrim_data():
    sql = "select CONCAT(province_name_,'-',city_name_) as province_city," \
          "city_today_confirm_,lastUpdateTime from tencent_virus_data " \
          "where city_today_confirm_ >0 and lastUpdateTime=(" \
          "select lastUpdateTime from tencent_virus_data " \
          "ORDER BY lastUpdateTime desc limit 1 )"

    res = query(sql)
    return res

# 目前各省市累计确诊数
def get_confrimUntilNow():
    sql = "select province_name_,sum(city_total_confirm_),lastUpdateTime " \
          "from tencent_virus_data where lastUpdateTime = ( " \
          "select lastUpdateTime from tencent_virus_data " \
          "order by lastUpdateTime desc limit 1) " \
          "group by province_name_"

    res = query(sql)
    return res

# 获取最新50条热搜数据
def get_hotPoint():
    sql = "select content,setDataTime from  hotpoint order by id desc limit 50"
    res = query(sql)
    return res
```

### 建立路由调用工具类方法返回数据值
- 这里需要注意的是需要引入写好的工具类
    - `import xxx`
- 在这里得到工具类查询数据库得到的值，再做进一步处理返回给页面关注的数据结构
```py
@app.route('/', methods=["get", "post"])
def hello_world():
    return render_template("index.html")


@app.route("/getTime")
def get_time():
    return utils.get_time()


@app.route("/getDailyData")
def get_daily_data():
    data = utils.get_daily_data()

    return jsonify({"today_confirm": data[0],
                    "total_nowConfirm": data[1],
                    "total_confirm": data[2],
                    "total_dead": data[3],
                    "total_deadRate": data[4],
                    "total_heal": data[5],
                    "total_healRate": data[6]})


@app.route("/getAreaData")
def get_area_data():
    areaData = []
    for city in utils.get_area_data():
        areaData.append({"name": city[0], "value": int(city[1])})

    return jsonify({"data": areaData})


@app.route("/getGeneralTrend")
def get_generalTrend_data():
    gT_data = utils.get_GeneralTrend_data()
    today_confirm, total_nowConfirm, total_confirm = [], [], []
    total_dead, total_heal, setDataTime = [], [], []

    for a, b, c, d, e, f in gT_data:
        today_confirm.append(a)
        total_nowConfirm.append(b)
        total_confirm.append(c)
        total_dead.append(d)
        total_heal.append(e)
        setDataTime.append(f.strftime("%m-%d"))

    # reverse() 没有返回值
    today_confirm.reverse()
    total_nowConfirm.reverse()
    total_confirm.reverse()
    total_dead.reverse()
    total_heal.reverse()
    setDataTime.reverse()

    return jsonify({"today_confirm": today_confirm,
                    "total_nowConfirm": total_nowConfirm,
                    "total_confirm": total_confirm,
                    "total_dead": total_dead,
                    "total_heal": total_heal,
                    "setDataTime": setDataTime})


@app.route("/getTodayNewConfrim")
def get_todayNewConfrim_data():
    tNC_data = utils.get_todayNewConfrim_data()
    province_city, city_today_confirm_ = [], []
    setDateTime = ""
    for i in tNC_data:
        province_city.append(i[0])
        city_today_confirm_.append(i[1])
        setDateTime = i[2].strftime("%Y/%m/%d")

    return jsonify({"setDateTime": setDateTime,
                    "city_today_confirm_": city_today_confirm_,
                    "province_city": province_city})


@app.route("/getConfrimUntilNow")
def get_confrimUntilNow_data():
    cUN_data = utils.get_confrimUntilNow()
    provinces = []
    setDateTime = ""
    provinceConfrim = []
    for i in cUN_data:
        provinces.append(i[0])
        setDateTime = i[2].strftime("%Y/%m/%d")
        pC = int(decimal.Decimal(i[1]).quantize(decimal.Decimal('0')))  # 把 Decimal 转换成可用于 json 序列化的 int 类型
        provinceConfrim.append({"name": i[0], "value": pC})

    return jsonify({"provinces": provinces,
                    "provinceConfrim": provinceConfrim,
                    "setDateTime": setDateTime})


@app.route("/getHotPoint")
def get_hotPoint_data():
    hP_data = utils.get_hotPoint()
    keywords = []
    setDataTime = ""
    for i in hP_data:
        content = i[0]
        keyword_weight = extract_tags(content, topK=20, withWeight=True)
        setDataTime = i[1].strftime("%Y/%m/%d")
        for j in keyword_weight:
            if not j[0].isdigit():  # 如果是数字就不加入数组
                weight = 20 * round(j[1], 1)
                keywords.append({"name": j[0], "value": str(weight)})

    return jsonify({"keywords": keywords,
                    "setDataTime": setDataTime})
```

### 页面请求数据并对接展示
- 这里展示数据用的 Echarts 
- Echarts 的话，需要关注它的 options 内需要传入的数据结构
- 然后在 ajax 请求获得数据后，赋给对应的位置即可
```JS
function getAreaData(){
    $.ajax({
        url: "/getAreaData",
        success:function (data) {
            center_option.series[0].data=data.data;
            center.setOption(center_option);
        },
        error:function (x) {
        }
    })
}
```
- 使用 Echarts 的 wordCloud 需要注意的是 5.0 版本不支持
- 需要切换 5.0 之前的版本
- 这样的话，可以在项目中引入两个不同版本的 Echarts.js 
- 然后打开其中一个，把内部的 echarts 对象全部修改
    - 比如需要单独把 4.0 版本的做处理，就打开该 js 文件，将全部默认的 echarts 对象修改成 echarts4
    - 区分开不同版本
- 最后获取对象的时候使用 echarts4 即可



## 树莓派部署测试

### 启动服务
- 配置好基本环境
- 然后直接通过 python 命令启动 flask 即可
- 需要对外访问就需要设置一下 host
```py
if __name__ == '__main__':
    app.run(host="0.0.0.0")
```
- 浏览器输入 ip:5000 即可看到服务

### Nginx 反代
- 配置好 nginx ,将服务的地址代理到 nginx
- 找到配置文件，我的树莓派默认的 nginx 配置文件是 `/etc/nginx/nginx.conf`
- 主要配置
```shell
    upstream hgo {

        server 127.0.0.1:5000 weight=10;
    }

    server {
        listen       8080 default_server;
        listen       [::]:8080 default_server;
        server_name  _;
        root         /usr/share/nginx/html;

#         Load configuration files for the default server block.
#         include /etc/nginx/default.d/*.conf;

        location / {
                proxy_pass http://hgo;
        }

        error_page 404 /404.html;
        location = /404.html {
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }

    }
```
- 整个配置文件
```shell
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

    upstream hgo {

        server 127.0.0.1:5000 weight=10;
    }

    server {
        listen       8080 default_server;
        listen       [::]:8080 default_server;
        server_name  _;
        root         /usr/share/nginx/html;

#         Load configuration files for the default server block.
#         include /etc/nginx/default.d/*.conf;

        location / {
                proxy_pass http://hgo;
        }

        error_page 404 /404.html;
        location = /404.html {
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }

    }

# Settings for a TLS enabled server.
#
#    server {
#        listen       443 ssl http2 default_server;
#        listen       [::]:443 ssl http2 default_server;
#        server_name  _;
#        root         /usr/share/nginx/html;
#
#        ssl_certificate "/etc/pki/nginx/server.crt";
#        ssl_certificate_key "/etc/pki/nginx/private/server.key";
#        ssl_session_cache shared:SSL:1m;
#        ssl_session_timeout  10m;
#        ssl_ciphers HIGH:!aNULL:!MD5;
#        ssl_prefer_server_ciphers on;
#
#        # Load configuration files for the default server block.
#        include /etc/nginx/default.d/*.conf;
#
#        location / {
#        }
#
#        error_page 404 /404.html;
#        location = /404.html {
#        }
#
#        error_page 500 502 503 504 /50x.html;
#        location = /50x.html {
#        }
#    }

}
```
- 这样一来就可通过 nginx 代理出来的地址去访问服务器内部的地址了


### 使用 WSGI 服务
- 不建议直接用 python 命令去启动 flask 
- 使用 gunicorn 将服务启动
- `gunicorn -b 127.0.0.1:5000 -D app:app`
- `gunicorn -b 127.0.0.1:5000 -D 文件名:文件内部的 flask 对象名`
    - `app = Flask(__name__)`

### 定时任务
- `crontab -l` 查看正在执行的定时任务
- `crontab -e` 编辑定时任务
```shell
# Edit this file to introduce tasks to be run by cron.
#
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
#
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
#
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
#
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
#
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
#
# For more information see the manual pages of crontab(5) and cron(8)
#
# m h  dom mon dow   command
45 * * * * python3 /home/pi/Documents/FkZi/gunicorn/virus.py dd >> /home/pi/Documents/log/dd 2>&1 &
45 * * * * python3 /home/pi/Documents/FkZi/gunicorn/virus.py vd >> /home/pi/Documents/log/vd 2>&1 &
45 * * * * python3 /home/pi/Documents/FkZi/gunicorn/virus.py hp >> /home/pi/Documents/log/hp 2>&1 &
```
- 定时任务执行成功可在对应的目录看到生成的日志文件 `/home/pi/Documents/log/dd`
- 可看到对应的参数设置
- `virus.py hp` 这里是给 py 脚本传递参数
- 需要在文件内设置
```py
if __name__ == '__main__':
    length = len(sys.argv)
    if length == 1:
        s = """
                请输入参数：
                dd 更新详细数据
                vd 更新汇总数据
                hp 更新热点信息
            """
        print(s)
    else:
        order = sys.argv[1]
        if order == "vd":
            update_virus_data()
        elif order == "dd":
            update_daily_data()
        elif order == "hp":
            update_hotPoint()
```

## 生产服务器部署
- 和在测试环境一样的步骤即可，这里生产的设备为 x86 的 Linux,OS 为 CentOS
- 先拉项目到设备里，把依赖安装好
- 将项目启动起来，配置 nginx 把端口代理出来
- 然后用 gunicorn 启动项目
- 设置定时任务
- 测试定时任务的脚本，把依赖装好，主要问题在 chromedirver
     - 👉 [爬虫在linux下启动selenium-安装谷歌浏览器和驱动](https://cloud.tencent.com/developer/article/1647905)
- 'chromedriver' executable needs to be in PATH. Please see https://sites.google.com/a/chromium.org/chromedriver/home
    - 如果出现这个问题，在代码里指定 chrome 对象驱动路径即可
    

## 遇到的问题
### print(cursor.execute(sql)) 为空
- 因为执行的语句未非查询语句，只有查询语句才有返回值
- 其他语句，如插入语句等，都需要提交事务 commit() 之后才能得到返回值 

### 在 selenium 中获取浏览器对象的时候，浏览器启动后一会就关闭了
- 因为获取浏览器的对象在方法中，方法执行完浏览器自然就跟着关闭了
- 如果需要浏览器一直存在，把浏览器对象在方法外部，使其成为全局对象就可以了

### 树莓派 arm 架构安装的 nginx 默认配置缺失
- 找到对的位置的配置文件
- 然后可以从其他已安装 nginx 的设备中把 配置文件 传过来

### nginx 没有把服务代理出来
- 可能需要配置一下组和用 root 来启动
```
- `groupadd nginx` 
- `useradd -g nginx nginx -s /sbin/nologin`
```
- 还需要关注当前的用户和 root 用户的包是否有 nginx

### arm 架构的 chromedriver 版本
- 首先是要确保 chrome 浏览器和 chromedriver 版本一致
- arm 架构的 chromedriver 实在难找，树莓派 4b 里的 chromiun 的版本为 78
    - arm 架构的 chromedriver 版本为 78 根本找不到 
- 这样的话，我们可以换个思路，把浏览器和驱动都升级到最新即可
- `sudo apt-get install chromium-browser` 更新最新
- `chromium-browser --version`
- 👉 [mirrors.tuna.tsinghua.edu.cn](https://mirrors.tuna.tsinghua.edu.cn/raspberrypi/pool/main/c/chromium-browser/)
- `sudo apt-get install chromium-chromedriver` 下载浏览器驱动，默认下了最新的
- 👉 [Launchpad.net](https://launchpad.net/+search?field.text=chromium-chromedriver+armhf)

### mysql 和 mariadb 的 group by 字段
- [Err] 1055 - Expression #3 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'virus.tencent_virus_data.lastUpdateTime' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
- 👉[MySQL GROUP BY 的问题](https://www.cnblogs.com/Wayou/p/mysql_group_by_issue.html)
- 👉[sql_mode之only_full_group_by](https://cloud.tencent.com/developer/article/1533773)

### mysql 和 mariadb 的 group by 结果顺序
- 👉[mysql - MariaDB上的“GROUP BY”的行为与MySQL不同](https://www.coder.work/article/508344)