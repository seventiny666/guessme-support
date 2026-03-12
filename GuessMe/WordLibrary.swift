import Foundation

enum GameCategory: String, CaseIterable {
    case random = "random"
    case idiom = "idiom"
    case food = "food"
    case sports = "sports"
    case knowledge = "knowledge"
    case popular = "popular"
    case animal = "animal"
    case classics = "classics"
    case internet = "internet"
    case profession = "profession"
    case cartoon = "cartoon"
    case music = "music"
    case movie = "movie"
    case travel = "travel"
    
    // 获取本地化的分类名称
    func localizedName(language: AppLanguage = LanguageManager.shared.currentLanguage) -> String {
        let categoryNames = CategoryLocalizedNames.getCategoryNames(language: language)
        return categoryNames[self] ?? self.rawValue
    }
    
    // 是否为专业版分类
    var isPro: Bool {
        switch self {
        case .random, .idiom, .food, .sports:
            return false // 免费分类（4个）
        default:
            return true // 专业版分类
        }
    }
    
    var icon: String {
        switch self {
        case .random: return "🎲"
        case .idiom: return "📚"
        case .food: return "🍜"
        case .sports: return "⚽️"
        case .knowledge: return "🏛️"
        case .popular: return "🔥"
        case .animal: return "🐼"
        case .classics: return "📖"
        case .internet: return "💻"
        case .profession: return "👔"
        case .cartoon: return "🎬"
        case .music: return "🎵"
        case .movie: return "🎬"
        case .travel: return "✈️"
        }
    }
    
    // 获取本地化的词汇列表
    func localizedWords(language: AppLanguage = LanguageManager.shared.currentLanguage) -> [String] {
        return CategoryLocalizedWords.getWords(for: self, language: language)
    }
    
    // 保持兼容性的words属性
    var words: [String] {
        return localizedWords()
    }
}

struct GameConfig {
    var category: GameCategory
    var duration: Int
    var wordList: [String]
}

// 分类名称本地化
struct CategoryLocalizedNames {
    static func getCategoryNames(language: AppLanguage) -> [GameCategory: String] {
        switch language {
        case .simplifiedChinese:
            return [
                .random: "随机",
                .idiom: "成语",
                .food: "美食",
                .sports: "运动",
                .knowledge: "常识",
                .popular: "流行语",
                .animal: "动物",
                .classics: "名著",
                .internet: "网络用语",
                .profession: "职业",
                .cartoon: "动画角色",
                .music: "音乐",
                .movie: "电影",
                .travel: "旅行"
            ]
        case .traditionalChinese:
            return [
                .random: "隨機",
                .idiom: "成語",
                .food: "美食",
                .sports: "運動",
                .knowledge: "常識",
                .popular: "流行語",
                .animal: "動物",
                .classics: "名著",
                .internet: "網路用語",
                .profession: "職業",
                .cartoon: "動畫角色",
                .music: "音樂",
                .movie: "電影",
                .travel: "旅行"
            ]
        case .english:
            return [
                .random: "Random",
                .idiom: "Idioms",
                .food: "Food",
                .sports: "Sports",
                .knowledge: "Knowledge",
                .popular: "Trending",
                .animal: "Animals",
                .classics: "Classics",
                .internet: "Internet",
                .profession: "Professions",
                .cartoon: "Cartoons",
                .music: "Music",
                .movie: "Movies",
                .travel: "Travel"
            ]
        case .japanese:
            return [
                .random: "ランダム",
                .idiom: "ことわざ",
                .food: "料理",
                .sports: "スポーツ",
                .knowledge: "一般常識",
                .popular: "流行語",
                .animal: "動物",
                .classics: "名作",
                .internet: "ネット用語",
                .profession: "職業",
                .cartoon: "アニメ",
                .music: "音楽",
                .movie: "映画",
                .travel: "旅行"
            ]
        case .korean:
            return [
                .random: "랜덤",
                .idiom: "속담",
                .food: "음식",
                .sports: "스포츠",
                .knowledge: "상식",
                .popular: "유행어",
                .animal: "동물",
                .classics: "명작",
                .internet: "인터넷 용어",
                .profession: "직업",
                .cartoon: "애니메이션",
                .music: "음악",
                .movie: "영화",
                .travel: "여행"
            ]
        case .spanish:
            return [
                .random: "Aleatorio",
                .idiom: "Modismos",
                .food: "Comida",
                .sports: "Deportes",
                .knowledge: "Conocimiento",
                .popular: "Tendencias",
                .animal: "Animales",
                .classics: "Clásicos",
                .internet: "Internet",
                .profession: "Profesiones",
                .cartoon: "Dibujos",
                .music: "Música",
                .movie: "Películas",
                .travel: "Viajes"
            ]
        }
    }
}

// 词汇本地化
struct CategoryLocalizedWords {
    static func getWords(for category: GameCategory, language: AppLanguage) -> [String] {
        let allWords = getAllWords(language: language)
        return allWords[category] ?? []
    }
    
    private static func getAllWords(language: AppLanguage) -> [GameCategory: [String]] {
        switch language {
        case .simplifiedChinese:
            return getChineseWords()
        case .traditionalChinese:
            return getTraditionalChineseWords()
        case .english:
            return getEnglishWords()
        case .japanese:
            return getJapaneseWords()
        case .korean:
            return getKoreanWords()
        case .spanish:
            return getSpanishWords()
        }
    }
    
    // 简体中文词汇 (保持原有词汇)
    private static func getChineseWords() -> [GameCategory: [String]] {
        return [
            .random: ["苹果", "大象", "打篮球", "骑自行车", "化妆", "游泳", "唱歌", "刷牙", "放风筝", "看电影", "跑步", "画画", "吃饭", "开车", "跳舞", "读书", "爬山", "钓鱼", "拍照", "洗衣服", "做饭", "扫地", "拖地", "浇花", "遛狗", "弹钢琴", "打游戏", "写字", "剪纸", "折纸", "踢足球", "打羽毛球", "打乒乓球", "下棋", "打牌", "唱戏", "跳绳", "滑冰", "滑雪", "冲浪", "潜水", "攀岩", "骑马", "射箭", "打高尔夫", "保龄球", "台球", "瑜伽", "太极拳", "广场舞"],
            .idiom: ["画蛇添足", "守株待兔", "亡羊补牢", "刻舟求剑", "掩耳盗铃", "井底之蛙", "狐假虎威", "杯弓蛇影", "买椟还珠", "南辕北辙", "画饼充饥", "望梅止渴", "竹篮打水", "对牛弹琴", "鸡鸣狗盗", "叶公好龙", "东施效颦", "邯郸学步", "滥竽充数", "自相矛盾", "鹬蚌相争", "塞翁失马", "愚公移山", "精卫填海", "夸父追日", "女娲补天", "盘古开天", "后羿射日", "嫦娥奔月", "牛郎织女", "孟母三迁", "凿壁偷光", "悬梁刺股", "囊萤映雪", "闻鸡起舞", "卧薪尝胆", "破釜沉舟", "背水一战", "纸上谈兵", "指鹿为马", "三顾茅庐", "草船借箭", "空城计", "苦肉计", "美人计", "连环计", "声东击西", "围魏救赵", "暗度陈仓", "笑里藏刀"],
            .food: ["火锅", "麻辣烫", "小笼包", "煎饼果子", "兰州拉面", "重庆小面", "北京烤鸭", "糖醋里脊", "宫保鸡丁", "麻婆豆腐", "红烧肉", "蒸蛋羹", "酸辣土豆丝", "西红柿鸡蛋", "青椒肉丝", "鱼香肉丝", "回锅肉", "东坡肉", "佛跳墙", "狮子头", "水煮鱼", "剁椒鱼头", "清蒸鲈鱼", "糖醋排骨", "红烧排骨", "粉蒸肉", "梅菜扣肉", "蒜泥白肉", "口水鸡", "辣子鸡", "大盘鸡", "手抓饭", "羊肉串", "烤全羊", "涮羊肉", "羊肉泡馍", "肉夹馍", "凉皮", "肠粉", "云吞", "馄饨", "饺子", "包子", "馒头", "花卷", "油条", "豆浆", "粥", "炒饭", "盖浇饭", "盒饭"],
            .sports: ["篮球", "足球", "乒乓球", "羽毛球", "网球", "排球", "棒球", "高尔夫", "游泳", "跑步", "跳远", "跳高", "铅球", "标枪", "跨栏", "接力赛", "马拉松", "竞走", "体操", "蹦床", "跳水", "花样游泳", "水球", "帆船", "赛艇", "皮划艇", "冲浪", "滑雪", "滑冰", "冰球", "花样滑冰", "短道速滑", "速度滑冰", "自由式滑雪", "单板滑雪", "冰壶", "拳击", "摔跤", "柔道", "跆拳道", "空手道", "击剑", "射箭", "射击", "马术", "自行车", "攀岩", "举重", "瑜伽", "太极拳"],
            .knowledge: ["万里长城", "故宫", "天安门", "兵马俑", "黄河", "长江", "泰山", "黄山", "桂林山水", "西湖", "九寨沟", "张家界", "天坛", "颐和园", "圆明园", "布达拉宫", "莫高窟", "乐山大佛", "峨眉山", "武当山", "少林寺", "白马寺", "大雁塔", "小雁塔", "钟楼", "鼓楼", "城隍庙", "豫园", "外滩", "东方明珠", "鸟巢", "水立方", "国家大剧院", "中央电视塔", "广州塔", "东方之门", "上海中心", "平遥古城", "丽江古城", "凤凰古城", "周庄", "乌镇", "西塘", "同里", "南浔", "甪直", "木渎", "锦溪", "千灯", "沙溪"],
            .popular: ["加油", "点赞", "转发", "收藏", "关注", "粉丝", "网红", "直播", "短视频", "自拍", "美颜", "滤镜", "表情包", "弹幕", "刷屏", "热搜", "话题", "标签", "艾特", "私信", "评论", "互动", "种草", "拔草", "安利", "打卡", "签到", "抽奖", "福利", "优惠", "秒杀", "拼团", "砍价", "红包", "转账", "扫码", "支付", "外卖", "快递", "团购", "预约", "排队", "叫号", "取号", "挂号", "缴费", "充值", "提现", "余额", "积分"],
            .animal: ["大熊猫", "东北虎", "金丝猴", "藏羚羊", "白鳍豚", "中华鲟", "扬子鳄", "丹顶鹤", "朱鹮", "大象", "长颈鹿", "狮子", "老虎", "猴子", "袋鼠", "考拉", "企鹅", "北极熊", "海豚", "鲸鱼", "鲨鱼", "海龟", "海豹", "海狮", "海象", "水母", "章鱼", "乌贼", "螃蟹", "龙虾", "蝴蝶", "蜜蜂", "蜻蜓", "瓢虫", "蚂蚁", "蜘蛛", "蝎子", "蜈蚣", "壁虎", "变色龙", "蛇", "乌龟", "鳄鱼", "青蛙", "蟾蜍", "蝌蚪", "鹦鹉", "孔雀", "天鹅", "鸽子"],
            .classics: ["西游记", "红楼梦", "水浒传", "三国演义", "哈利波特", "小王子", "简爱", "傲慢与偏见", "百年孤独", "1984", "了不起的盖茨比", "追风筝的人", "白夜行", "解忧杂货店", "活着", "平凡的世界", "围城", "骆驼祥子", "朝花夕拾", "呐喊", "彷徨", "家", "春", "秋", "雷雨", "日出", "茶馆", "边城", "四世同堂", "京华烟云", "倾城之恋", "半生缘", "金锁记", "红玫瑰与白玫瑰", "城南旧事", "呼兰河传", "子夜", "林家铺子", "寒夜", "雾", "雨", "电", "激流三部曲", "爱情三部曲", "农村三部曲", "抗战三部曲", "人间喜剧", "悲惨世界", "巴黎圣母院"],
            .internet: ["点赞", "转发", "收藏", "关注", "粉丝", "网红", "直播", "短视频", "自拍", "美颜", "滤镜", "表情包", "弹幕", "刷屏", "热搜", "话题", "标签", "私信", "评论", "互动", "打卡", "签到", "抽奖", "福利", "优惠", "秒杀", "拼团", "砍价", "红包", "转账", "扫码", "支付", "外卖", "快递", "团购", "预约", "排队", "叫号", "取号", "挂号", "缴费", "充值", "提现", "余额", "积分", "会员", "等级", "勋章", "成就"],
            .profession: ["医生", "护士", "教师", "警察", "消防员", "厨师", "服务员", "司机", "快递员", "外卖员", "保安", "清洁工", "园丁", "农民", "工人", "建筑工", "电工", "水暖工", "木工", "油漆工", "程序员", "设计师", "工程师", "建筑师", "律师", "法官", "检察官", "会计", "出纳", "银行职员", "记者", "编辑", "主持人", "播音员", "摄影师", "摄像师", "导演", "演员", "歌手", "舞蹈家", "画家", "雕塑家", "作家", "诗人", "翻译", "导游", "空姐", "飞行员", "船长", "列车员"],
            .cartoon: ["孙悟空", "猪八戒", "沙僧", "唐僧", "哪吒", "二郎神", "太上老君", "玉皇大帝", "王母娘娘", "观音菩萨", "葫芦娃", "蛇精", "蝎子精", "黑猫警长", "一只耳", "舒克", "贝塔", "大头儿子", "小头爸爸", "围裙妈妈", "喜羊羊", "美羊羊", "懒羊羊", "沸羊羊", "灰太狼", "红太狼", "熊大", "熊二", "光头强", "猪猪侠", "超人强", "菲菲", "波比", "小呆呆", "海绵宝宝", "派大星", "章鱼哥", "蟹老板", "小猪佩奇", "乔治", "猪爸爸", "猪妈妈", "汪汪队", "阿奇", "毛毛", "天天", "小砾", "灰灰", "路马"],
            .music: ["钢琴", "吉他", "小提琴", "大提琴", "古筝", "琵琶", "二胡", "笛子", "萨克斯", "架子鼓", "贝斯", "口琴", "手风琴", "竖琴", "长笛", "单簧管", "双簧管", "小号", "长号", "圆号", "大号", "木琴", "三角铁", "铃鼓", "沙锤", "唱歌", "跳舞", "说唱", "摇滚", "流行", "古典", "民谣", "爵士", "蓝调", "乡村", "电音", "嘻哈", "R&B", "灵魂乐", "雷鬼", "朋克", "金属", "交响乐", "歌剧", "音乐会", "演唱会", "合唱", "独唱", "二重唱", "乐队"],
            .movie: ["喜剧片", "动作片", "爱情片", "科幻片", "恐怖片", "悬疑片", "犯罪片", "战争片", "历史片", "传记片", "纪录片", "动画片", "音乐片", "歌舞片", "西部片", "武侠片", "功夫片", "魔幻片", "冒险片", "灾难片", "惊悚片", "文艺片", "剧情片", "家庭片", "儿童片", "青春片", "校园片", "励志片", "温情片", "黑色幽默", "导演", "演员", "编剧", "摄影", "剪辑", "配乐", "特效", "化妆", "服装", "道具", "灯光", "录音", "制片", "发行", "首映", "票房", "影评", "奥斯卡", "金像奖", "金鸡奖"],
            .travel: ["北京", "上海", "广州", "深圳", "杭州", "成都", "重庆", "西安", "南京", "武汉", "苏州", "厦门", "青岛", "大连", "三亚", "桂林", "丽江", "拉萨", "乌鲁木齐", "哈尔滨", "长城", "故宫", "兵马俑", "外滩", "西湖", "黄山", "张家界", "九寨沟", "峨眉山", "泰山", "华山", "武当山", "少林寺", "布达拉宫", "莫高窟", "天安门", "鸟巢", "东方明珠", "迪士尼", "长隆", "海洋公园", "欢乐谷", "世界之窗", "民俗村", "古镇", "古城", "海滩", "雪山", "草原"]
        ]
    }
    // 繁体中文词汇
    private static func getTraditionalChineseWords() -> [GameCategory: [String]] {
        return [
            .random: ["蘋果", "大象", "打籃球", "騎自行車", "化妝", "游泳", "唱歌", "刷牙", "放風箏", "看電影", "跑步", "畫畫", "吃飯", "開車", "跳舞", "讀書", "爬山", "釣魚", "拍照", "洗衣服", "做飯", "掃地", "拖地", "澆花", "遛狗", "彈鋼琴", "打遊戲", "寫字", "剪紙", "摺紙", "踢足球", "打羽毛球", "打乒乓球", "下棋", "打牌", "唱戲", "跳繩", "滑冰", "滑雪", "衝浪", "潛水", "攀岩", "騎馬", "射箭", "打高爾夫", "保齡球", "撞球", "瑜伽", "太極拳", "廣場舞"],
            .idiom: ["畫蛇添足", "守株待兔", "亡羊補牢", "刻舟求劍", "掩耳盜鈴", "井底之蛙", "狐假虎威", "杯弓蛇影", "買櫝還珠", "南轅北轍", "畫餅充飢", "望梅止渴", "竹籃打水", "對牛彈琴", "雞鳴狗盜", "葉公好龍", "東施效顰", "邯鄲學步", "濫竽充數", "自相矛盾", "鷸蚌相爭", "塞翁失馬", "愚公移山", "精衛填海", "夸父追日", "女媧補天", "盤古開天", "后羿射日", "嫦娥奔月", "牛郎織女", "孟母三遷", "鑿壁偷光", "懸梁刺股", "囊螢映雪", "聞雞起舞", "臥薪嘗膽", "破釜沉舟", "背水一戰", "紙上談兵", "指鹿為馬", "三顧茅廬", "草船借箭", "空城計", "苦肉計", "美人計", "連環計", "聲東擊西", "圍魏救趙", "暗度陳倉", "笑裡藏刀"],
            .food: ["火鍋", "麻辣燙", "小籠包", "煎餅果子", "蘭州拉麵", "重慶小麵", "北京烤鴨", "糖醋里脊", "宮保雞丁", "麻婆豆腐", "紅燒肉", "蒸蛋羹", "酸辣土豆絲", "西紅柿雞蛋", "青椒肉絲", "魚香肉絲", "回鍋肉", "東坡肉", "佛跳牆", "獅子頭", "水煮魚", "剁椒魚頭", "清蒸鱸魚", "糖醋排骨", "紅燒排骨", "粉蒸肉", "梅菜扣肉", "蒜泥白肉", "口水雞", "辣子雞", "大盤雞", "手抓飯", "羊肉串", "烤全羊", "涮羊肉", "羊肉泡饃", "肉夾饃", "涼皮", "腸粉", "雲吞", "餛飩", "餃子", "包子", "饅頭", "花卷", "油條", "豆漿", "粥", "炒飯", "蓋澆飯", "盒飯"],
            .sports: ["籃球", "足球", "乒乓球", "羽毛球", "網球", "排球", "棒球", "高爾夫", "游泳", "跑步", "跳遠", "跳高", "鉛球", "標槍", "跨欄", "接力賽", "馬拉松", "競走", "體操", "蹦床", "跳水", "花樣游泳", "水球", "帆船", "賽艇", "皮划艇", "衝浪", "滑雪", "滑冰", "冰球", "花樣滑冰", "短道速滑", "速度滑冰", "自由式滑雪", "單板滑雪", "冰壺", "拳擊", "摔跤", "柔道", "跆拳道", "空手道", "擊劍", "射箭", "射擊", "馬術", "自行車", "攀岩", "舉重", "瑜伽", "太極拳"],
            .knowledge: ["萬里長城", "故宮", "天安門", "兵馬俑", "黃河", "長江", "泰山", "黃山", "桂林山水", "西湖", "九寨溝", "張家界", "天壇", "頤和園", "圓明園", "布達拉宮", "莫高窟", "樂山大佛", "峨眉山", "武當山", "少林寺", "白馬寺", "大雁塔", "小雁塔", "鐘樓", "鼓樓", "城隍廟", "豫園", "外灘", "東方明珠", "鳥巢", "水立方", "國家大劇院", "中央電視塔", "廣州塔", "東方之門", "上海中心", "平遙古城", "麗江古城", "鳳凰古城", "周莊", "烏鎮", "西塘", "同里", "南潯", "甪直", "木瀆", "錦溪", "千燈", "沙溪"],
            .popular: ["加油", "點讚", "轉發", "收藏", "關注", "粉絲", "網紅", "直播", "短視頻", "自拍", "美顏", "濾鏡", "表情包", "彈幕", "刷屏", "熱搜", "話題", "標籤", "艾特", "私信", "評論", "互動", "種草", "拔草", "安利", "打卡", "簽到", "抽獎", "福利", "優惠", "秒殺", "拼團", "砍價", "紅包", "轉賬", "掃碼", "支付", "外賣", "快遞", "團購", "預約", "排隊", "叫號", "取號", "掛號", "繳費", "充值", "提現", "餘額", "積分"],
            .animal: ["大熊貓", "東北虎", "金絲猴", "藏羚羊", "白鰭豚", "中華鱘", "揚子鱷", "丹頂鶴", "朱鹮", "大象", "長頸鹿", "獅子", "老虎", "猴子", "袋鼠", "考拉", "企鵝", "北極熊", "海豚", "鯨魚", "鯊魚", "海龜", "海豹", "海獅", "海象", "水母", "章魚", "烏賊", "螃蟹", "龍蝦", "蝴蝶", "蜜蜂", "蜻蜓", "瓢蟲", "螞蟻", "蜘蛛", "蠍子", "蜈蚣", "壁虎", "變色龍", "蛇", "烏龜", "鱷魚", "青蛙", "蟾蜍", "蝌蚪", "鸚鵡", "孔雀", "天鵝", "鴿子"],
            .classics: ["西遊記", "紅樓夢", "水滸傳", "三國演義", "哈利波特", "小王子", "簡愛", "傲慢與偏見", "百年孤獨", "1984", "了不起的蓋茨比", "追風箏的人", "白夜行", "解憂雜貨店", "活著", "平凡的世界", "圍城", "駱駝祥子", "朝花夕拾", "吶喊", "彷徨", "家", "春", "秋", "雷雨", "日出", "茶館", "邊城", "四世同堂", "京華煙雲", "傾城之戀", "半生緣", "金鎖記", "紅玫瑰與白玫瑰", "城南舊事", "呼蘭河傳", "子夜", "林家鋪子", "寒夜", "霧", "雨", "電", "激流三部曲", "愛情三部曲", "農村三部曲", "抗戰三部曲", "人間喜劇", "悲慘世界", "巴黎聖母院"],
            .internet: ["點讚", "轉發", "收藏", "關注", "粉絲", "網紅", "直播", "短視頻", "自拍", "美顏", "濾鏡", "表情包", "彈幕", "刷屏", "熱搜", "話題", "標籤", "私信", "評論", "互動", "打卡", "簽到", "抽獎", "福利", "優惠", "秒殺", "拼團", "砍價", "紅包", "轉賬", "掃碼", "支付", "外賣", "快遞", "團購", "預約", "排隊", "叫號", "取號", "掛號", "繳費", "充值", "提現", "餘額", "積分", "會員", "等級", "勳章", "成就"],
            .profession: ["醫生", "護士", "教師", "警察", "消防員", "廚師", "服務員", "司機", "快遞員", "外賣員", "保安", "清潔工", "園丁", "農民", "工人", "建築工", "電工", "水暖工", "木工", "油漆工", "程序員", "設計師", "工程師", "建築師", "律師", "法官", "檢察官", "會計", "出納", "銀行職員", "記者", "編輯", "主持人", "播音員", "攝影師", "攝像師", "導演", "演員", "歌手", "舞蹈家", "畫家", "雕塑家", "作家", "詩人", "翻譯", "導遊", "空姐", "飛行員", "船長", "列車員"],
            .cartoon: ["孫悟空", "豬八戒", "沙僧", "唐僧", "哪吒", "二郎神", "太上老君", "玉皇大帝", "王母娘娘", "觀音菩薩", "葫蘆娃", "蛇精", "蠍子精", "黑貓警長", "一隻耳", "舒克", "貝塔", "大頭兒子", "小頭爸爸", "圍裙媽媽", "喜羊羊", "美羊羊", "懶羊羊", "沸羊羊", "灰太狼", "紅太狼", "熊大", "熊二", "光頭強", "豬豬俠", "超人強", "菲菲", "波比", "小呆呆", "海綿寶寶", "派大星", "章魚哥", "蟹老闆", "小豬佩奇", "喬治", "豬爸爸", "豬媽媽", "汪汪隊", "阿奇", "毛毛", "天天", "小礫", "灰灰", "路馬"],
            .music: ["鋼琴", "吉他", "小提琴", "大提琴", "古箏", "琵琶", "二胡", "笛子", "薩克斯", "架子鼓", "貝斯", "口琴", "手風琴", "豎琴", "長笛", "單簧管", "雙簧管", "小號", "長號", "圓號", "大號", "木琴", "三角鐵", "鈴鼓", "沙錘", "唱歌", "跳舞", "說唱", "搖滾", "流行", "古典", "民謠", "爵士", "藍調", "鄉村", "電音", "嘻哈", "R&B", "靈魂樂", "雷鬼", "朋克", "金屬", "交響樂", "歌劇", "音樂會", "演唱會", "合唱", "獨唱", "二重唱", "樂隊"],
            .movie: ["喜劇片", "動作片", "愛情片", "科幻片", "恐怖片", "懸疑片", "犯罪片", "戰爭片", "歷史片", "傳記片", "紀錄片", "動畫片", "音樂片", "歌舞片", "西部片", "武俠片", "功夫片", "魔幻片", "冒險片", "災難片", "驚悚片", "文藝片", "劇情片", "家庭片", "兒童片", "青春片", "校園片", "勵志片", "溫情片", "黑色幽默", "導演", "演員", "編劇", "攝影", "剪輯", "配樂", "特效", "化妝", "服裝", "道具", "燈光", "錄音", "製片", "發行", "首映", "票房", "影評", "奧斯卡", "金像獎", "金雞獎"],
            .travel: ["北京", "上海", "廣州", "深圳", "杭州", "成都", "重慶", "西安", "南京", "武漢", "蘇州", "廈門", "青島", "大連", "三亞", "桂林", "麗江", "拉薩", "烏魯木齊", "哈爾濱", "長城", "故宮", "兵馬俑", "外灘", "西湖", "黃山", "張家界", "九寨溝", "峨眉山", "泰山", "華山", "武當山", "少林寺", "布達拉宮", "莫高窟", "天安門", "鳥巢", "東方明珠", "迪士尼", "長隆", "海洋公園", "歡樂谷", "世界之窗", "民俗村", "古鎮", "古城", "海灘", "雪山", "草原"]
        ]
    }
    // 英语词汇
    private static func getEnglishWords() -> [GameCategory: [String]] {
        return [
            .random: ["Apple", "Elephant", "Basketball", "Bicycle", "Makeup", "Swimming", "Singing", "Brushing teeth", "Flying kite", "Watching movie", "Running", "Drawing", "Eating", "Driving", "Dancing", "Reading", "Climbing", "Fishing", "Taking photo", "Laundry", "Cooking", "Sweeping", "Mopping", "Watering plants", "Walking dog", "Playing piano", "Gaming", "Writing", "Paper cutting", "Origami", "Soccer", "Badminton", "Ping pong", "Chess", "Card game", "Opera", "Jump rope", "Ice skating", "Skiing", "Surfing", "Diving", "Rock climbing", "Horse riding", "Archery", "Golf", "Bowling", "Pool", "Yoga", "Tai chi", "Square dance"],
            .idiom: ["Actions speak louder than words", "A picture is worth a thousand words", "Don't count your chickens before they hatch", "The early bird catches the worm", "Don't put all your eggs in one basket", "When in Rome do as the Romans do", "A penny saved is a penny earned", "Better late than never", "Don't judge a book by its cover", "Every cloud has a silver lining", "Rome wasn't built in a day", "The grass is always greener", "Kill two birds with one stone", "Let sleeping dogs lie", "Practice makes perfect", "Time heals all wounds", "You can't have your cake and eat it too", "Where there's a will there's a way", "All that glitters is not gold", "Beauty is in the eye of the beholder", "Curiosity killed the cat", "Easy come easy go", "Fortune favors the bold", "Honesty is the best policy", "If it ain't broke don't fix it", "Knowledge is power", "Laughter is the best medicine", "Money doesn't grow on trees", "No pain no gain", "Patience is a virtue", "The pen is mightier than the sword", "There's no place like home", "Time is money", "Two wrongs don't make a right", "When the going gets tough the tough get going", "You reap what you sow", "A friend in need is a friend indeed", "Absence makes the heart grow fonder", "All good things must come to an end", "Beggars can't be choosers", "Don't bite the hand that feeds you", "Every dog has its day", "Good things come to those who wait", "Haste makes waste", "It's never too late to learn", "Look before you leap"],
            .food: ["Pizza", "Hamburger", "Sushi", "Pasta", "Sandwich", "Salad", "Soup", "Steak", "Chicken", "Fish", "Rice", "Bread", "Cheese", "Eggs", "Milk", "Coffee", "Tea", "Juice", "Water", "Beer", "Wine", "Cake", "Ice cream", "Chocolate", "Cookies", "Fruit", "Vegetables", "Potato", "Tomato", "Onion", "Garlic", "Pepper", "Salt", "Sugar", "Honey", "Butter", "Oil", "Vinegar", "Sauce", "Ketchup", "Mustard", "Mayonnaise", "Yogurt", "Cereal", "Oatmeal", "Pancakes", "Waffles", "Toast", "Bagel", "Muffin"],
            .sports: ["Basketball", "Football", "Soccer", "Tennis", "Baseball", "Golf", "Swimming", "Running", "Cycling", "Boxing", "Wrestling", "Gymnastics", "Volleyball", "Badminton", "Table tennis", "Hockey", "Cricket", "Rugby", "Skiing", "Snowboarding", "Surfing", "Skateboarding", "Rock climbing", "Hiking", "Fishing", "Hunting", "Archery", "Bowling", "Billiards", "Darts", "Chess", "Checkers", "Poker", "Bridge", "Scrabble", "Monopoly", "Yoga", "Pilates", "Aerobics", "Weightlifting", "Bodybuilding", "Martial arts", "Karate", "Judo", "Taekwondo", "Fencing", "Sailing", "Rowing", "Canoeing", "Kayaking"],
            .knowledge: ["History", "Geography", "Science", "Mathematics", "Literature", "Art", "Music", "Philosophy", "Psychology", "Sociology", "Anthropology", "Economics", "Politics", "Law", "Medicine", "Biology", "Chemistry", "Physics", "Astronomy", "Geology", "Meteorology", "Oceanography", "Ecology", "Botany", "Zoology", "Genetics", "Biochemistry", "Microbiology", "Neuroscience", "Computer science", "Engineering", "Architecture", "Design", "Photography", "Film", "Theater", "Dance", "Sculpture", "Painting", "Drawing", "Pottery", "Jewelry", "Fashion", "Cooking", "Gardening", "Sports", "Travel", "Languages", "Religion", "Mythology"],
            .popular: ["Trending", "Viral", "Hashtag", "Selfie", "Like", "Share", "Follow", "Subscribe", "Comment", "Post", "Story", "Live stream", "Video", "Photo", "Meme", "GIF", "Emoji", "Filter", "Edit", "Upload", "Download", "App", "Social media", "Influencer", "Content", "Creator", "Blogger", "Vlogger", "Podcast", "YouTube", "TikTok", "Instagram", "Facebook", "Twitter", "Snapchat", "WhatsApp", "Zoom", "Netflix", "Spotify", "Amazon", "Google", "Apple", "Microsoft", "Tesla", "Bitcoin", "Cryptocurrency", "NFT", "Metaverse", "AI", "VR"],
            .animal: ["Dog", "Cat", "Bird", "Fish", "Horse", "Cow", "Pig", "Sheep", "Goat", "Chicken", "Duck", "Goose", "Turkey", "Rabbit", "Hamster", "Guinea pig", "Mouse", "Rat", "Elephant", "Lion", "Tiger", "Bear", "Wolf", "Fox", "Deer", "Moose", "Elk", "Giraffe", "Zebra", "Hippo", "Rhino", "Monkey", "Ape", "Gorilla", "Chimpanzee", "Kangaroo", "Koala", "Panda", "Penguin", "Polar bear", "Seal", "Whale", "Dolphin", "Shark", "Octopus", "Jellyfish", "Crab", "Lobster", "Shrimp", "Butterfly"],
            .classics: ["Romeo and Juliet", "Hamlet", "Macbeth", "Pride and Prejudice", "Jane Eyre", "Wuthering Heights", "Great Expectations", "Oliver Twist", "A Tale of Two Cities", "The Adventures of Tom Sawyer", "The Adventures of Huckleberry Finn", "Moby Dick", "The Great Gatsby", "To Kill a Mockingbird", "1984", "Animal Farm", "Brave New World", "The Catcher in the Rye", "Lord of the Flies", "The Lord of the Rings", "The Hobbit", "Harry Potter", "The Chronicles of Narnia", "Alice in Wonderland", "The Little Prince", "Don Quixote", "War and Peace", "Anna Karenina", "Crime and Punishment", "The Brothers Karamazov", "Les Misérables", "The Hunchback of Notre Dame", "The Count of Monte Cristo", "The Three Musketeers", "Frankenstein", "Dracula", "Dr. Jekyll and Mr. Hyde", "The Picture of Dorian Gray", "The Importance of Being Earnest", "A Christmas Carol", "Robinson Crusoe", "Gulliver's Travels", "The Canterbury Tales", "Beowulf", "The Odyssey", "The Iliad", "The Divine Comedy", "Paradise Lost", "Faust", "The Metamorphosis"],
            .internet: ["Website", "Browser", "Search", "Email", "Password", "Username", "Login", "Logout", "Download", "Upload", "Stream", "Cloud", "Server", "Database", "Software", "Hardware", "Network", "WiFi", "Bluetooth", "USB", "HD", "SSD", "RAM", "CPU", "GPU", "Motherboard", "Monitor", "Keyboard", "Mouse", "Printer", "Scanner", "Camera", "Microphone", "Speaker", "Headphones", "Smartphone", "Tablet", "Laptop", "Desktop", "Gaming", "Virtual reality", "Augmented reality", "Artificial intelligence", "Machine learning", "Blockchain", "Cryptocurrency", "Bitcoin", "Ethereum", "NFT", "Metaverse"],
            .profession: ["Doctor", "Nurse", "Teacher", "Police officer", "Firefighter", "Chef", "Waiter", "Driver", "Pilot", "Engineer", "Architect", "Lawyer", "Judge", "Accountant", "Banker", "Manager", "Secretary", "Receptionist", "Salesperson", "Cashier", "Mechanic", "Electrician", "Plumber", "Carpenter", "Painter", "Cleaner", "Gardener", "Farmer", "Veterinarian", "Dentist", "Pharmacist", "Therapist", "Counselor", "Social worker", "Journalist", "Reporter", "Editor", "Writer", "Author", "Translator", "Interpreter", "Artist", "Musician", "Singer", "Actor", "Director", "Producer", "Photographer", "Designer", "Programmer"],
            .cartoon: ["Mickey Mouse", "Donald Duck", "Goofy", "Minnie Mouse", "Bugs Bunny", "Daffy Duck", "Porky Pig", "Tweety", "Sylvester", "Tom and Jerry", "Scooby Doo", "Shaggy", "Fred", "Velma", "Daphne", "Popeye", "Olive Oyl", "Bluto", "Betty Boop", "Felix the Cat", "Garfield", "Odie", "Jon", "Snoopy", "Charlie Brown", "Lucy", "Linus", "Woodstock", "The Simpsons", "Homer", "Marge", "Bart", "Lisa", "Maggie", "SpongeBob", "Patrick", "Squidward", "Mr. Krabs", "Plankton", "Sandy", "Teenage Mutant Ninja Turtles", "Leonardo", "Donatello", "Raphael", "Michelangelo", "Shredder", "Splinter", "Pokemon", "Pikachu", "Ash"],
            .music: ["Piano", "Guitar", "Violin", "Drums", "Bass", "Saxophone", "Trumpet", "Flute", "Clarinet", "Oboe", "Trombone", "French horn", "Tuba", "Harp", "Cello", "Double bass", "Banjo", "Mandolin", "Ukulele", "Harmonica", "Accordion", "Organ", "Synthesizer", "Microphone", "Amplifier", "Speaker", "Headphones", "Record", "CD", "MP3", "Streaming", "Concert", "Orchestra", "Band", "Choir", "Solo", "Duet", "Trio", "Quartet", "Symphony", "Opera", "Musical", "Song", "Melody", "Harmony", "Rhythm", "Beat", "Tempo", "Key", "Scale"],
            .movie: ["Action", "Adventure", "Comedy", "Drama", "Horror", "Thriller", "Romance", "Science fiction", "Fantasy", "Mystery", "Crime", "War", "Western", "Musical", "Animation", "Documentary", "Biography", "History", "Family", "Children", "Teen", "Adult", "Independent", "Foreign", "Silent", "Black and white", "Color", "3D", "IMAX", "Director", "Producer", "Actor", "Actress", "Screenwriter", "Cinematographer", "Editor", "Composer", "Costume designer", "Makeup artist", "Special effects", "Stunt", "Camera", "Lighting", "Sound", "Music", "Dialogue", "Narration", "Subtitle", "Dubbing", "Premiere"],
            .travel: ["Airport", "Airplane", "Flight", "Passport", "Visa", "Luggage", "Suitcase", "Backpack", "Hotel", "Motel", "Hostel", "Resort", "Vacation", "Holiday", "Trip", "Journey", "Adventure", "Sightseeing", "Tourism", "Tourist", "Guide", "Map", "Compass", "GPS", "Camera", "Photo", "Souvenir", "Postcard", "Beach", "Mountain", "Desert", "Forest", "Lake", "River", "Ocean", "Island", "City", "Town", "Village", "Country", "Continent", "Culture", "Language", "Food", "Restaurant", "Museum", "Monument", "Castle", "Church", "Temple"]
        ]
    }
    // 日语词汇
    private static func getJapaneseWords() -> [GameCategory: [String]] {
        return [
            .random: ["りんご", "ぞう", "バスケットボール", "じてんしゃ", "けしょう", "およぎ", "うた", "はみがき", "たこあげ", "えいが", "はしる", "え", "たべる", "うんてん", "おどり", "よむ", "やま", "つり", "しゃしん", "せんたく", "りょうり", "そうじ", "みず", "はな", "いぬ", "ピアノ", "ゲーム", "かく", "きる", "おりがみ", "サッカー", "バドミントン", "たっきゅう", "しょうぎ", "トランプ", "かぶき", "なわとび", "スケート", "スキー", "サーフィン", "ダイビング", "ロッククライミング", "じょうば", "きゅうどう", "ゴルフ", "ボウリング", "ビリヤード", "ヨガ", "たいきょくけん", "ダンス"],
            .idiom: ["いしのうえにもさんねん", "ねこにこばん", "さるもきからおちる", "とりあとをたたず", "いぬもあるけばぼうにあたる", "のどもとすぎればあつさをわすれる", "ひとのふりみてわがふりなおせ", "みっつごのたましいひゃくまで", "はなよりだんご", "ちりもつもればやまとなる", "いそがばまわれ", "ころんでもただではおきない", "てんはじぶくをたすく", "なせばなる", "ろーまはいちにちにしてならず", "きゅうそくはねこをかむ", "ひとをのろわばあなふたつ", "あきらめたらそこでしあいしゅうりょう", "なんじもてきをしり", "いちねんのけいはがんたんにあり", "ときはかねなり", "けんこうはいちばんのたから", "まけるがかち", "ひとはみかけによらない", "ちいさなしんせつ", "おもいやりがたいせつ", "がんばればできる", "あいはちからなり", "ゆめはかなう", "みらいはあかるい", "きぼうをもつ", "しあわせはじぶんでつくる", "えがおがいちばん", "ありがとうのきもち", "やさしさがたいせつ", "ともだちはたから", "かぞくはたいせつ", "へいわがいちばん", "しぜんをたいせつに", "ちきゅうをまもろう", "みんなでなかよく", "たすけあいのこころ", "おもいやりのきもち", "かんしゃのこころ", "まごころをたいせつに", "しんじつはひとつ", "せいぎはかつ", "あいとへいわ", "みらいへのきぼう"],
            .food: ["すし", "らーめん", "うどん", "そば", "やきとり", "てんぷら", "とんかつ", "やきにく", "しゃぶしゃぶ", "すきやき", "おでん", "みそしる", "ごはん", "パン", "めん", "さかな", "にく", "やさい", "くだもの", "たまご", "ぎゅうにゅう", "おちゃ", "コーヒー", "ビール", "さけ", "みず", "ジュース", "アイスクリーム", "ケーキ", "チョコレート", "クッキー", "キャンディー", "おかし", "せんべい", "もち", "だんご", "どらやき", "たいやき", "おこのみやき", "たこやき", "やきそば", "チャーハン", "カレー", "ハンバーガー", "ピザ", "パスタ", "サラダ", "スープ", "サンドイッチ", "おべんとう"],
            .sports: ["やきゅう", "サッカー", "バスケットボール", "バレーボール", "テニス", "たっきゅう", "バドミントン", "ゴルフ", "すいえい", "りくじょう", "たいそう", "じゅうどう", "からて", "けんどう", "きゅうどう", "すもう", "ボクシング", "レスリング", "スキー", "スケート", "スノーボード", "サーフィン", "ダイビング", "ヨット", "つり", "ハイキング", "とざん", "サイクリング", "マラソン", "ジョギング", "ウォーキング", "ヨガ", "エアロビクス", "フィットネス", "きんとれ", "ストレッチ", "たいそう", "ダンス", "バレエ", "しゃこうダンス", "ひっぷほっぷ", "ぶれいくダンス", "フラダンス", "にほんぶよう", "たいきょくけん", "きこう", "あいきどう", "なぎなた", "やぶさめ"],
            .knowledge: ["れきし", "ちり", "かがく", "すうがく", "こくご", "えいご", "びじゅつ", "おんがく", "たいいく", "どうとく", "しゃかい", "りか", "せいぶつ", "かがく", "ぶつり", "てんもん", "ちがく", "きしょう", "かいよう", "しょくぶつ", "どうぶつ", "いでん", "のうかがく", "いがく", "こうがく", "けんちく", "デザイン", "しゃしん", "えいが", "えんげき", "ぶんがく", "てつがく", "しんりがく", "しゃかいがく", "けいざいがく", "せいじがく", "ほうりつ", "きょういく", "げんご", "しゅうきょう", "しんわ", "みんぞく", "でんとう", "ぶんか", "げいじゅつ", "こうげい", "しょどう", "いけばな", "ちゃどう"],
            .popular: ["トレンド", "バイラル", "ハッシュタグ", "セルフィー", "いいね", "シェア", "フォロー", "チャンネルとうろく", "コメント", "とうこう", "ストーリー", "ライブはいしん", "どうが", "しゃしん", "ミーム", "GIF", "えもじ", "フィルター", "へんしゅう", "アップロード", "ダウンロード", "アプリ", "SNS", "インフルエンサー", "コンテンツ", "クリエイター", "ブロガー", "ユーチューバー", "ポッドキャスト", "YouTube", "TikTok", "Instagram", "Facebook", "Twitter", "LINE", "Zoom", "Netflix", "Spotify", "Amazon", "Google", "Apple", "Microsoft", "Tesla", "ビットコイン", "あんごうつうか", "NFT", "メタバース", "AI", "VR"],
            .animal: ["いぬ", "ねこ", "とり", "さかな", "うま", "うし", "ぶた", "ひつじ", "やぎ", "にわとり", "あひる", "がちょう", "しちめんちょう", "うさぎ", "ハムスター", "モルモット", "ねずみ", "ぞう", "らいおん", "とら", "くま", "おおかみ", "きつね", "しか", "きりん", "しまうま", "かば", "さい", "さる", "ゴリラ", "チンパンジー", "カンガルー", "コアラ", "パンダ", "ペンギン", "しろくま", "あざらし", "くじら", "いるか", "さめ", "たこ", "くらげ", "かに", "えび", "ちょう", "はち", "とんぼ", "てんとうむし", "あり"],
            .classics: ["げんじものがたり", "たけとりものがたり", "いせものがたり", "へいけものがたり", "つれづれぐさ", "ほうじょうき", "まくらのそうし", "こじき", "にほんしょき", "まんようしゅう", "こきんわかしゅう", "しんこきんわかしゅう", "おくのほそみち", "とうかいどうちゅうひざくりげ", "そんごくう", "みずのまるごん", "たろうかじゃ", "ももたろう", "うらしまたろう", "かぐやひめ", "いっすんぼうし", "はなさかじいさん", "したきりすずめ", "つるのおんがえし", "かちかちやま", "さるかにがっせん", "おむすびころりん", "ぶんぶくちゃがま", "ねずみのよめいり", "かさじぞう", "ゆきおんな", "やまんば", "てんぐ", "かっぱ", "おに", "ばけもの", "ようかい", "おばけ", "まじょ", "まほうつかい", "にんじゃ", "さむらい", "ひめ", "おうじ", "おうさま", "おひめさま", "ようせい", "りゅう", "ほうおう", "きりん"],
            .internet: ["ウェブサイト", "ブラウザ", "けんさく", "メール", "パスワード", "ユーザーめい", "ログイン", "ログアウト", "ダウンロード", "アップロード", "ストリーミング", "クラウド", "サーバー", "データベース", "ソフトウェア", "ハードウェア", "ネットワーク", "WiFi", "Bluetooth", "USB", "HD", "SSD", "RAM", "CPU", "GPU", "マザーボード", "モニター", "キーボード", "マウス", "プリンター", "スキャナー", "カメラ", "マイク", "スピーカー", "ヘッドホン", "スマートフォン", "タブレット", "ノートパソコン", "デスクトップ", "ゲーム", "バーチャルリアリティ", "かくちょうげんじつ", "じんこうちのう", "きかいがくしゅう", "ブロックチェーン", "あんごうつうか", "ビットコイン", "イーサリアム", "NFT"],
            .profession: ["いしゃ", "かんごし", "せんせい", "けいさつかん", "しょうぼうし", "コック", "ウェイター", "うんてんしゅ", "パイロット", "エンジニア", "けんちくし", "べんごし", "さいばんかん", "かいけいし", "ぎんこういん", "マネージャー", "ひしょ", "うけつけ", "えいぎょう", "レジ", "せいびし", "でんきこう", "はいかんこう", "だいく", "ペンキや", "そうじふ", "にわし", "のうか", "じゅういし", "はいしゃ", "やくざいし", "セラピスト", "カウンセラー", "しゃかいふくしし", "ジャーナリスト", "きしゃ", "へんしゅうしゃ", "さっか", "ちょしゃ", "ほんやくしゃ", "つうやく", "げいじゅつか", "おんがくか", "かしゅ", "はいゆう", "かんとく", "プロデューサー", "しゃしんか", "デザイナー", "プログラマー"],
            .cartoon: ["ドラえもん", "のびた", "しずか", "ジャイアン", "スネ夫", "アンパンマン", "バイキンマン", "ドキンちゃん", "しょくぱんまん", "カレーパンマン", "ちびまるこちゃん", "まるこ", "たまちゃん", "はなわくん", "サザエさん", "サザエ", "カツオ", "ワカメ", "マスオ", "タラちゃん", "ポケモン", "ピカチュウ", "サトシ", "ロケットだん", "ムサシ", "コジロウ", "ニャース", "ワンピース", "ルフィ", "ゾロ", "ナミ", "ウソップ", "サンジ", "チョッパー", "ロビン", "フランキー", "ブルック", "ジンベエ", "ナルト", "サスケ", "サクラ", "カカシ", "ドラゴンボール", "ごくう", "ベジータ", "ピッコロ", "クリリン", "ヤムチャ"],
            .music: ["ピアノ", "ギター", "バイオリン", "ドラム", "ベース", "サックス", "トランペット", "フルート", "クラリネット", "オーボエ", "トロンボーン", "ホルン", "チューバ", "ハープ", "チェロ", "コントラバス", "バンジョー", "マンドリン", "ウクレレ", "ハーモニカ", "アコーディオン", "オルガン", "シンセサイザー", "マイク", "アンプ", "スピーカー", "ヘッドホン", "レコード", "CD", "MP3", "ストリーミング", "コンサート", "オーケストラ", "バンド", "がっしょう", "ソロ", "デュエット", "トリオ", "カルテット", "こうきょうきょく", "オペラ", "ミュージカル", "うた", "メロディー", "ハーモニー", "リズム", "ビート", "テンポ", "ちょう", "おんかい"],
            .movie: ["アクション", "アドベンチャー", "コメディ", "ドラマ", "ホラー", "スリラー", "ロマンス", "SF", "ファンタジー", "ミステリー", "はんざい", "せんそう", "せいぶ", "ミュージカル", "アニメ", "ドキュメンタリー", "でんき", "れきし", "かぞく", "こども", "ティーン", "おとな", "どくりつ", "がいこく", "サイレント", "しろくろ", "カラー", "3D", "IMAX", "かんとく", "プロデューサー", "はいゆう", "じょゆう", "きゃくほんか", "さつえいかんとく", "へんしゅう", "さっきょくか", "いしょうデザイナー", "メイクアップアーティスト", "とくしゅこうか", "スタント", "カメラ", "しょうめい", "おんきょう", "おんがく", "かいわ", "ナレーション", "じまく", "ふきかえ", "しさくしえん"],
            .travel: ["くうこう", "ひこうき", "フライト", "パスポート", "ビザ", "にもつ", "スーツケース", "リュックサック", "ホテル", "モーテル", "ホステル", "リゾート", "きゅうか", "ホリデー", "りょこう", "たび", "ぼうけん", "かんこう", "かんこうきゃく", "ガイド", "ちず", "らしんばん", "GPS", "カメラ", "しゃしん", "おみやげ", "ポストカード", "ビーチ", "やま", "さばく", "もり", "みずうみ", "かわ", "うみ", "しま", "とし", "まち", "むら", "くに", "たいりく", "ぶんか", "げんご", "たべもの", "レストラン", "はくぶつかん", "きねんひ", "しろ", "きょうかい", "じいん", "じんじゃ"]
        ]
    }
    // 韩语词汇
    private static func getKoreanWords() -> [GameCategory: [String]] {
        return [
            .random: ["사과", "코끼리", "농구", "자전거", "화장", "수영", "노래", "양치질", "연날리기", "영화보기", "달리기", "그림그리기", "밥먹기", "운전", "춤추기", "독서", "등산", "낚시", "사진찍기", "빨래", "요리", "청소", "물주기", "산책", "피아노", "게임", "글쓰기", "종이접기", "축구", "배드민턴", "탁구", "바둑", "카드게임", "연극", "줄넘기", "스케이트", "스키", "서핑", "다이빙", "암벽등반", "승마", "양궁", "골프", "볼링", "당구", "요가", "태극권", "댄스"],
            .idiom: ["가는 말이 고와야 오는 말이 곱다", "개구리 올챙이 적 생각 못한다", "고생 끝에 낙이 온다", "구슬이 서 말이라도 꿰어야 보배", "금강산도 식후경", "낮말은 새가 듣고 밤말은 쥐가 듣는다", "돌다리도 두들겨 보고 건너라", "뜻이 있는 곳에 길이 있다", "로마는 하루아침에 이루어지지 않았다", "말보다는 행동이 중요하다", "백지장도 맞들면 낫다", "세월이 약이다", "시작이 반이다", "아는 것이 힘이다", "열심히 하면 된다", "우물 안 개구리", "작은 고추가 맵다", "천리 길도 한 걸음부터", "하늘이 무너져도 솟아날 구멍이 있다", "호랑이도 제 말 하면 온다", "가족이 최고다", "건강이 최고다", "꿈은 이루어진다", "노력하면 된다", "도전하면 성공한다", "마음이 중요하다", "배려가 필요하다", "사랑이 최고다", "성실이 최고다", "신뢰가 중요하다", "약속을 지켜라", "열정이 중요하다", "우정이 소중하다", "인내가 필요하다", "정직이 최고다", "진실이 승리한다", "최선을 다하라", "평화가 최고다", "행복이 목표다", "희망을 가져라"],
            .food: ["김치", "불고기", "비빔밥", "냉면", "삼겹살", "갈비", "치킨", "피자", "햄버거", "라면", "우동", "짜장면", "짬뽕", "탕수육", "만두", "떡볶이", "순대", "호떡", "붕어빵", "계란빵", "김밥", "도시락", "밥", "국", "찌개", "반찬", "김", "된장", "고추장", "간장", "설탕", "소금", "마늘", "양파", "고추", "배추", "무", "당근", "감자", "고구마", "사과", "배", "포도", "딸기", "바나나", "오렌지", "수박", "참외", "복숭아"],
            .sports: ["축구", "야구", "농구", "배구", "테니스", "탁구", "배드민턴", "골프", "수영", "육상", "체조", "유도", "태권도", "검도", "궁도", "씨름", "복싱", "레슬링", "스키", "스케이트", "스노보드", "서핑", "다이빙", "요트", "낚시", "하이킹", "등산", "사이클", "마라톤", "조깅", "걷기", "요가", "에어로빅", "피트니스", "근력운동", "스트레칭", "체조", "댄스", "발레", "사교댄스", "힙합", "브레이크댄스", "플라댄스", "한국무용", "태극권", "기공", "합기도", "검술", "말타기"],
            .knowledge: ["역사", "지리", "과학", "수학", "국어", "영어", "미술", "음악", "체육", "도덕", "사회", "과학", "생물", "화학", "물리", "천문", "지학", "기상", "해양", "식물", "동물", "유전", "뇌과학", "의학", "공학", "건축", "디자인", "사진", "영화", "연극", "문학", "철학", "심리학", "사회학", "경제학", "정치학", "법률", "교육", "언어", "종교", "신화", "민속", "전통", "문화", "예술", "공예", "서예", "꽃꽂이", "차도"],
            .popular: ["트렌드", "바이럴", "해시태그", "셀카", "좋아요", "공유", "팔로우", "구독", "댓글", "게시물", "스토리", "라이브방송", "동영상", "사진", "밈", "GIF", "이모지", "필터", "편집", "업로드", "다운로드", "앱", "SNS", "인플루언서", "콘텐츠", "크리에이터", "블로거", "유튜버", "팟캐스트", "유튜브", "틱톡", "인스타그램", "페이스북", "트위터", "카카오톡", "줌", "넷플릭스", "스포티파이", "아마존", "구글", "애플", "마이크로소프트", "테슬라", "비트코인", "암호화폐", "NFT", "메타버스", "AI", "VR"],
            .animal: ["개", "고양이", "새", "물고기", "말", "소", "돼지", "양", "염소", "닭", "오리", "거위", "칠면조", "토끼", "햄스터", "기니피그", "쥐", "코끼리", "사자", "호랑이", "곰", "늑대", "여우", "사슴", "기린", "얼룩말", "하마", "코뿔소", "원숭이", "고릴라", "침팬지", "캥거루", "코알라", "판다", "펭귄", "북극곰", "바다표범", "고래", "돌고래", "상어", "문어", "해파리", "게", "새우", "나비", "벌", "잠자리", "무당벌레", "개미"],
            .classics: ["삼국지", "수호지", "서유기", "홍루몽", "해리포터", "어린왕자", "제인에어", "오만과편견", "백년의고독", "1984", "위대한개츠비", "연을쫓는아이", "백야행", "해결사잡화점", "살아있다", "평범한세계", "성", "낙타상자", "아침꽃저녁따기", "외침", "방황", "집", "봄", "가을", "뇌우", "일출", "찻집", "변성", "사세동당", "경화연운", "경성지연", "반생연", "금쇄기", "홍장미와백장미", "성남구사", "호란하전", "자야", "임가포자", "한야", "안개", "비", "전기", "격류삼부곡", "사랑삼부곡", "농촌삼부곡", "항전삼부곡", "인간희극", "비참한세계", "파리성모원"],
            .internet: ["웹사이트", "브라우저", "검색", "이메일", "비밀번호", "사용자명", "로그인", "로그아웃", "다운로드", "업로드", "스트리밍", "클라우드", "서버", "데이터베이스", "소프트웨어", "하드웨어", "네트워크", "와이파이", "블루투스", "USB", "하드디스크", "SSD", "램", "CPU", "그래픽카드", "메인보드", "모니터", "키보드", "마우스", "프린터", "스캐너", "카메라", "마이크", "스피커", "헤드폰", "스마트폰", "태블릿", "노트북", "데스크톱", "게임", "가상현실", "증강현실", "인공지능", "머신러닝", "블록체인", "암호화폐", "비트코인", "이더리움", "NFT"],
            .profession: ["의사", "간호사", "선생님", "경찰관", "소방관", "요리사", "웨이터", "운전사", "조종사", "엔지니어", "건축가", "변호사", "판사", "회계사", "은행원", "매니저", "비서", "접수원", "영업사원", "계산원", "정비사", "전기기사", "배관공", "목수", "페인트공", "청소부", "정원사", "농부", "수의사", "치과의사", "약사", "치료사", "상담사", "사회복지사", "기자", "리포터", "편집자", "작가", "저자", "번역가", "통역사", "예술가", "음악가", "가수", "배우", "감독", "프로듀서", "사진가", "디자이너", "프로그래머"],
            .cartoon: ["뽀로로", "크롱", "에디", "루피", "포비", "패티", "해리", "또봇", "카봇", "헬로카봇", "터닝메카드", "신비아파트", "마샤와곰", "페파피그", "뽀잉", "코코몽", "타요", "로보카폴리", "슈퍼윙스", "출동슈퍼윙스", "미키마우스", "도널드덕", "구피", "미니마우스", "벅스버니", "대피덕", "포키피그", "트위티", "실베스터", "톰과제리", "스쿠비두", "뽀빠이", "올리브", "베티붑", "펠릭스", "가필드", "오디", "존", "스누피", "찰리브라운", "루시", "라이너스", "우드스톡", "심슨가족", "호머", "마지", "바트", "리사", "매기"],
            .music: ["피아노", "기타", "바이올린", "드럼", "베이스", "색소폰", "트럼펫", "플루트", "클라리넷", "오보에", "트롬본", "호른", "튜바", "하프", "첼로", "콘트라베이스", "밴조", "만돌린", "우쿨렐레", "하모니카", "아코디언", "오르간", "신시사이저", "마이크", "앰프", "스피커", "헤드폰", "레코드", "CD", "MP3", "스트리밍", "콘서트", "오케스트라", "밴드", "합창", "솔로", "듀엣", "트리오", "콰르텟", "교향곡", "오페라", "뮤지컬", "노래", "멜로디", "하모니", "리듬", "비트", "템포", "조", "음계"],
            .movie: ["액션", "어드벤처", "코미디", "드라마", "호러", "스릴러", "로맨스", "SF", "판타지", "미스터리", "범죄", "전쟁", "서부", "뮤지컬", "애니메이션", "다큐멘터리", "전기", "역사", "가족", "어린이", "청소년", "성인", "독립", "외국", "무성", "흑백", "컬러", "3D", "아이맥스", "감독", "프로듀서", "배우", "여배우", "각본가", "촬영감독", "편집자", "작곡가", "의상디자이너", "메이크업아티스트", "특수효과", "스턴트", "카메라", "조명", "음향", "음악", "대화", "내레이션", "자막", "더빙", "시사회"],
            .travel: ["공항", "비행기", "항공편", "여권", "비자", "짐", "여행가방", "배낭", "호텔", "모텔", "호스텔", "리조트", "휴가", "홀리데이", "여행", "여정", "모험", "관광", "관광객", "가이드", "지도", "나침반", "GPS", "카메라", "사진", "기념품", "엽서", "해변", "산", "사막", "숲", "호수", "강", "바다", "섬", "도시", "마을", "촌", "나라", "대륙", "문화", "언어", "음식", "식당", "박물관", "기념물", "성", "교회", "절", "신사"]
        ]
    }
    
    // 西班牙语词汇
    private static func getSpanishWords() -> [GameCategory: [String]] {
        return [
            .random: ["Manzana", "Elefante", "Baloncesto", "Bicicleta", "Maquillaje", "Nadar", "Cantar", "Cepillarse", "Cometa", "Película", "Correr", "Dibujar", "Comer", "Conducir", "Bailar", "Leer", "Escalar", "Pescar", "Fotografía", "Lavar", "Cocinar", "Limpiar", "Regar", "Pasear", "Piano", "Jugar", "Escribir", "Recortar", "Origami", "Fútbol", "Bádminton", "Ping pong", "Ajedrez", "Cartas", "Teatro", "Saltar", "Patinar", "Esquiar", "Surfear", "Bucear", "Escalar", "Montar", "Tiro", "Golf", "Bolos", "Billar", "Yoga", "Tai chi", "Danza"],
            .idiom: ["Más vale tarde que nunca", "No hay mal que por bien no venga", "A quien madruga Dios le ayuda", "En boca cerrada no entran moscas", "Ojos que no ven corazón que no siente", "Del dicho al hecho hay mucho trecho", "Agua que no has de beber déjala correr", "A caballo regalado no se le mira el diente", "Camarón que se duerme se lo lleva la corriente", "El que mucho abarca poco aprieta", "No por mucho madrugar amanece más temprano", "Perro que ladra no muerde", "Dime con quién andas y te diré quién eres", "El saber no ocupa lugar", "La letra con sangre entra", "Más vale pájaro en mano que ciento volando", "No dejes para mañana lo que puedas hacer hoy", "El que busca encuentra", "La práctica hace al maestro", "Roma no se construyó en un día", "La familia es lo primero", "La salud es lo más importante", "Los sueños se hacen realidad", "El esfuerzo da frutos", "El desafío trae éxito", "El corazón es importante", "La consideración es necesaria", "El amor es lo mejor", "La sinceridad es lo mejor", "La confianza es importante", "Cumple las promesas", "La pasión es importante", "La amistad es preciosa", "La paciencia es necesaria", "La honestidad es lo mejor", "La verdad triunfa", "Da lo mejor de ti", "La paz es lo mejor", "La felicidad es el objetivo", "Ten esperanza"],
            .food: ["Pizza", "Hamburguesa", "Sushi", "Pasta", "Sándwich", "Ensalada", "Sopa", "Bistec", "Pollo", "Pescado", "Arroz", "Pan", "Queso", "Huevos", "Leche", "Café", "Té", "Jugo", "Agua", "Cerveza", "Vino", "Pastel", "Helado", "Chocolate", "Galletas", "Fruta", "Verduras", "Papa", "Tomate", "Cebolla", "Ajo", "Pimienta", "Sal", "Azúcar", "Miel", "Mantequilla", "Aceite", "Vinagre", "Salsa", "Ketchup", "Mostaza", "Mayonesa", "Yogur", "Cereal", "Avena", "Panqueques", "Waffles", "Tostada", "Bagel"],
            .sports: ["Baloncesto", "Fútbol americano", "Fútbol", "Tenis", "Béisbol", "Golf", "Natación", "Correr", "Ciclismo", "Boxeo", "Lucha", "Gimnasia", "Voleibol", "Bádminton", "Tenis de mesa", "Hockey", "Cricket", "Rugby", "Esquí", "Snowboard", "Surf", "Skateboard", "Escalada", "Senderismo", "Pesca", "Caza", "Tiro con arco", "Bolos", "Billar", "Dardos", "Ajedrez", "Damas", "Póker", "Bridge", "Scrabble", "Monopoly", "Yoga", "Pilates", "Aeróbicos", "Levantamiento", "Culturismo", "Artes marciales", "Karate", "Judo", "Taekwondo", "Esgrima", "Vela", "Remo", "Canoa"],
            .knowledge: ["Historia", "Geografía", "Ciencia", "Matemáticas", "Literatura", "Arte", "Música", "Filosofía", "Psicología", "Sociología", "Antropología", "Economía", "Política", "Derecho", "Medicina", "Biología", "Química", "Física", "Astronomía", "Geología", "Meteorología", "Oceanografía", "Ecología", "Botánica", "Zoología", "Genética", "Bioquímica", "Microbiología", "Neurociencia", "Informática", "Ingeniería", "Arquitectura", "Diseño", "Fotografía", "Cine", "Teatro", "Danza", "Escultura", "Pintura", "Dibujo", "Cerámica", "Joyería", "Moda", "Cocina", "Jardinería", "Deportes", "Viajes", "Idiomas", "Religión", "Mitología"],
            .popular: ["Tendencia", "Viral", "Hashtag", "Selfie", "Me gusta", "Compartir", "Seguir", "Suscribir", "Comentar", "Publicar", "Historia", "Transmisión", "Video", "Foto", "Meme", "GIF", "Emoji", "Filtro", "Editar", "Subir", "Descargar", "App", "Redes sociales", "Influencer", "Contenido", "Creador", "Blogger", "YouTuber", "Podcast", "YouTube", "TikTok", "Instagram", "Facebook", "Twitter", "WhatsApp", "Zoom", "Netflix", "Spotify", "Amazon", "Google", "Apple", "Microsoft", "Tesla", "Bitcoin", "Criptomoneda", "NFT", "Metaverso", "IA", "RV"],
            .animal: ["Perro", "Gato", "Pájaro", "Pez", "Caballo", "Vaca", "Cerdo", "Oveja", "Cabra", "Pollo", "Pato", "Ganso", "Pavo", "Conejo", "Hámster", "Cobaya", "Ratón", "Elefante", "León", "Tigre", "Oso", "Lobo", "Zorro", "Ciervo", "Jirafa", "Cebra", "Hipopótamo", "Rinoceronte", "Mono", "Gorila", "Chimpancé", "Canguro", "Koala", "Panda", "Pingüino", "Oso polar", "Foca", "Ballena", "Delfín", "Tiburón", "Pulpo", "Medusa", "Cangrejo", "Langosta", "Camarón", "Mariposa", "Abeja", "Libélula", "Mariquita"],
            .classics: ["Romeo y Julieta", "Hamlet", "Macbeth", "Orgullo y prejuicio", "Jane Eyre", "Cumbres borrascosas", "Grandes esperanzas", "Oliver Twist", "Historia de dos ciudades", "Tom Sawyer", "Huckleberry Finn", "Moby Dick", "El gran Gatsby", "Matar un ruiseñor", "1984", "Rebelión en la granja", "Un mundo feliz", "El guardián", "El señor de las moscas", "El señor de los anillos", "El hobbit", "Harry Potter", "Las crónicas de Narnia", "Alicia en el país", "El principito", "Don Quijote", "Guerra y paz", "Ana Karenina", "Crimen y castigo", "Los hermanos Karamazov", "Los miserables", "El jorobado", "El conde de Montecristo", "Los tres mosqueteros", "Frankenstein", "Drácula", "Jekyll y Hyde", "Dorian Gray", "La importancia", "Cuento de Navidad", "Robinson Crusoe", "Los viajes de Gulliver", "Cuentos de Canterbury", "Beowulf", "La Odisea", "La Ilíada", "La Divina Comedia", "El paraíso perdido", "Fausto"],
            .internet: ["Sitio web", "Navegador", "Buscar", "Correo", "Contraseña", "Usuario", "Iniciar", "Cerrar", "Descargar", "Subir", "Transmitir", "Nube", "Servidor", "Base de datos", "Software", "Hardware", "Red", "WiFi", "Bluetooth", "USB", "Disco duro", "SSD", "RAM", "CPU", "GPU", "Placa madre", "Monitor", "Teclado", "Ratón", "Impresora", "Escáner", "Cámara", "Micrófono", "Altavoz", "Auriculares", "Teléfono", "Tableta", "Portátil", "Escritorio", "Juegos", "Realidad virtual", "Realidad aumentada", "Inteligencia artificial", "Aprendizaje automático", "Blockchain", "Criptomoneda", "Bitcoin", "Ethereum", "NFT"],
            .profession: ["Doctor", "Enfermera", "Maestro", "Policía", "Bombero", "Chef", "Camarero", "Conductor", "Piloto", "Ingeniero", "Arquitecto", "Abogado", "Juez", "Contador", "Banquero", "Gerente", "Secretaria", "Recepcionista", "Vendedor", "Cajero", "Mecánico", "Electricista", "Fontanero", "Carpintero", "Pintor", "Limpiador", "Jardinero", "Granjero", "Veterinario", "Dentista", "Farmacéutico", "Terapeuta", "Consejero", "Trabajador social", "Periodista", "Reportero", "Editor", "Escritor", "Autor", "Traductor", "Intérprete", "Artista", "Músico", "Cantante", "Actor", "Director", "Productor", "Fotógrafo", "Diseñador"],
            .cartoon: ["Mickey Mouse", "Donald Duck", "Goofy", "Minnie Mouse", "Bugs Bunny", "Daffy Duck", "Porky Pig", "Tweety", "Sylvester", "Tom y Jerry", "Scooby Doo", "Shaggy", "Fred", "Velma", "Daphne", "Popeye", "Olivia", "Brutus", "Betty Boop", "Félix el Gato", "Garfield", "Odie", "Jon", "Snoopy", "Charlie Brown", "Lucy", "Linus", "Woodstock", "Los Simpson", "Homero", "Marge", "Bart", "Lisa", "Maggie", "Bob Esponja", "Patricio", "Calamardo", "Cangrejo", "Plankton", "Arenita", "Tortugas Ninja", "Leonardo", "Donatello", "Rafael", "Miguel Ángel", "Destructor", "Splinter", "Pokémon", "Pikachu"],
            .music: ["Piano", "Guitarra", "Violín", "Batería", "Bajo", "Saxofón", "Trompeta", "Flauta", "Clarinete", "Oboe", "Trombón", "Trompa", "Tuba", "Arpa", "Violonchelo", "Contrabajo", "Banjo", "Mandolina", "Ukelele", "Armónica", "Acordeón", "Órgano", "Sintetizador", "Micrófono", "Amplificador", "Altavoz", "Auriculares", "Disco", "CD", "MP3", "Streaming", "Concierto", "Orquesta", "Banda", "Coro", "Solo", "Dúo", "Trío", "Cuarteto", "Sinfonía", "Ópera", "Musical", "Canción", "Melodía", "Armonía", "Ritmo", "Compás", "Tempo", "Tono", "Escala"],
            .movie: ["Acción", "Aventura", "Comedia", "Drama", "Terror", "Suspense", "Romance", "Ciencia ficción", "Fantasía", "Misterio", "Crimen", "Guerra", "Western", "Musical", "Animación", "Documental", "Biografía", "Historia", "Familia", "Infantil", "Adolescente", "Adulto", "Independiente", "Extranjero", "Mudo", "Blanco y negro", "Color", "3D", "IMAX", "Director", "Productor", "Actor", "Actriz", "Guionista", "Cinematógrafo", "Editor", "Compositor", "Diseñador", "Maquillador", "Efectos especiales", "Doble", "Cámara", "Iluminación", "Sonido", "Música", "Diálogo", "Narración", "Subtítulo", "Doblaje"],
            .travel: ["Aeropuerto", "Avión", "Vuelo", "Pasaporte", "Visa", "Equipaje", "Maleta", "Mochila", "Hotel", "Motel", "Hostal", "Resort", "Vacaciones", "Feriado", "Viaje", "Jornada", "Aventura", "Turismo", "Turista", "Guía", "Mapa", "Brújula", "GPS", "Cámara", "Foto", "Recuerdo", "Postal", "Playa", "Montaña", "Desierto", "Bosque", "Lago", "Río", "Océano", "Isla", "Ciudad", "Pueblo", "Villa", "País", "Continente", "Cultura", "Idioma", "Comida", "Restaurante", "Museo", "Monumento", "Castillo", "Iglesia", "Templo"]
        ]
    }
}