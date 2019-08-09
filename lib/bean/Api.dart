class Api {
  static final String HOST = "https://www.wanandroid.com/";

  /// 轮播图
  static final String BANNER_LIST = HOST + "banner/json";

  ///首页数据
  static final String HOME_LIST = HOST + "article/list/";

  ///知识体系http://www.wanandroid.com/tree/json
  static final String KNOWLEDGE_TREE = HOST + "tree/json";

  ///热门搜索==>http://www.wanandroid.com/hotkey/json
  static final String HOT_WORD = HOST + "hotkey/json";

  ///常用网站
  static final String HOT_FRIEND = HOST + "friend/json";

  ///项目http://www.wanandroid.com/project/tree/json
  static final String PROJECT_TREE = HOST + "project/tree/json";

  ///项目列表http://www.wanandroid.com/project/list/1/json?cid=294
  static final String PROJECT_LIST = HOST + "project/list/";

  ///登录 https://www.wanandroid.com/user/login
  static final String LOGIN = HOST + "user/login";

  ///注册 https://www.wanandroid.com/user/register
  static final String REGISTER = HOST + "user/register";
}
