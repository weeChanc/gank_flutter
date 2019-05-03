用 GitHub 登录
干货集中营
每日分享妹子图 和 技术干货，还有供大家中午休息的休闲视频


搜索真的好了！不骗你！
闲读订阅到邮箱外包通缉令提交干货RSS 订阅
干货集中营 API 文档
你可以通过 Api，获取所有公开数据。

2018-7-17 日更新：
新增：
获取最新一天的干货 
例如： http://gank.io/api/today 

2018-6-13 日更新：
新增：
获取闲读的主分类 
例如： http://gank.io/api/xiandu/categories 

获取闲读的子分类 
例如： http://gank.io/api/xiandu/category/wow 
注：
category 后面可接受参数为主分类返回的en_name,例如【apps， wow， android，iOS】
获取闲读数据 
例如： http://gank.io/api/xiandu/data/id/appinn/count/10/page/1 
注：
id 后面可接受参数为子分类返回的id
page 第几页，从1开始
count 每页的个数
2016-6-12 日更新：

搜索 API
http://gank.io/api/search/query/listview/category/Android/count/10/page/1 
注：
category 后面可接受参数 all | Android | iOS | 休息视频 | 福利 | 拓展资源 | 前端 | 瞎推荐 | App
count 最大 50
2016-5-11 日更新:

获取某几日干货网站数据:
http://gank.io/api/history/content/2/1

注： 2 代表 2 个数据，1 代表：取第一页数据
获取特定日期网站数据:
http://gank.io/api/history/content/day/2016/05/11

2016-2-28 日更新:

获取发过干货日期接口:
http://gank.io/api/day/history 方式 GET

2016-2-27 日更新:

支持提交干货到审核区:
https://gank.io/api/add2gank 方式: POST

请勿滥用此接口,不然我还得加身份校验代码,很麻烦的!!!
提交表单格式如下:

字段	描述	备注
url	想要提交的网页地址	
desc	对干货内容的描述	单独的文字描述
who	提交者 ID	干货提交者的网络 ID
type	干货类型	可选参数: Android | iOS | 休息视频 | 福利 | 拓展资源 | 前端 | 瞎推荐 | App
debug	当前提交为测试数据	如果想要测试数据是否合法, 请设置 debug 为 true! 可选参数: true | false
该 Api 玩儿法推荐:
直接在你的博客发表博文处嵌入该代码, 感觉不错的博文可以自动提交过来
写个 Chrome | Firefox | Safari 插件, 让更多人来分享干货, 妹子图和休息视频
分类数据: http://gank.io/api/data/数据类型/请求个数/第几页

数据类型： 福利 | Android | iOS | 休息视频 | 拓展资源 | 前端 | all
请求个数： 数字，大于0
第几页：数字，大于0
例：
http://gank.io/api/data/Android/10/1
http://gank.io/api/data/福利/10/1
http://gank.io/api/data/iOS/20/2
http://gank.io/api/data/all/20/2
每日数据： http://gank.io/api/day/年/月/日

例：
http://gank.io/api/day/2015/08/06
随机数据：http://gank.io/api/random/data/分类/个数

数据类型：福利 | Android | iOS | 休息视频 | 拓展资源 | 前端
个数： 数字，大于0
例：
http://gank.io/api/random/data/Android/20
如果有更多需求，请随时 戳我！

感谢所有为干货集中营默默付出的汉子们。

API历史编辑们妹子们好基友
合作伙伴

 
快速推广优秀开发者工具，即刻加入！

沪ICP备13038357号-9

反馈建议返回顶部