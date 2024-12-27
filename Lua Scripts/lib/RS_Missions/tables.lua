Labels = {
    None = get_label_text("NONE"),
    Default = get_label_text("DEFAULT_LABEL"),
    Yes = get_label_text("HUD_YES"),
    No = get_label_text("HUD_NO"),
    Other = get_label_text("PIM_THMISC"),
    Complete = get_label_text("AWARD_COMPLETE"),
    Reset = get_label_text("PIM_CRST"),

    NONE = get_label_text("CELEB_NONE"),

    Sell = get_label_text("HC_SELL"),
    Source = get_label_text("HC_STEAL"),
    Buy = get_label_text("ITEM_BUY"),
    Supplies = get_label_text("BRS_NMRESUP"),
    Product = get_label_text("BRS_NM"),
    Computer = get_label_text("MP_CLUB_HUB_PC"),
    Safe = get_label_text("FHQ_SAFE"),

    HeistPrep = get_label_text("FHBM_STSTART_T"),
    HeistSetup = get_label_text("SPC_TXT_PLN"),

    RANDOM = get_label_text("EF_RANDOM"),
    PREP = get_label_text("H4P_PREP_TAB"),
    FINALE = get_label_text("H4P_FINALE_TAB"),
    SETUP = get_label_text("TR_STSTART_T2"),

    Office = get_label_text("PM_SPAWN_OFFICE"),
    Warehouse = get_label_text("MP_WHOUSE_BLP1"),
    SpecialCargo = get_label_text("SCONTRA_CTRA"),
    SpecialItem = get_label_text("CONTRASPECIAL"),
    VehicleWarehouse = get_label_text("IE_WHOUSE_BLIP1"),
    VehicleCargo = get_label_text("BBB_VEHCARGO"),

    Facility = get_label_text("CELL_DBASE"),
    Bunker = get_label_text("CELL_BUNKER"),
    Hangar = get_label_text("CELL_HANGAR"),
    Nightclub = get_label_text("CELL_CLUB"),
    AcidLab = get_label_text("CELL_ACID_LAB"),
    Arcade = get_label_text("CELL_ARCADE"),
    Agency = get_label_text("CELL_FIX_HQ"),
    AutoShop = get_label_text("CELL_AUTO_SHP"),
    SalvageYard = get_label_text("CELL_SLVG_YRD"),
    Terrorbyte = get_label_text("TERBYTE"),
    MasterControlTerminal = get_label_text("ARC_MCT_BLIP"),
    RecordAStudios = get_label_text("CELL_REC_A"),
    BailOffice = get_label_text("CELL_BAIL_OF"),
    GarmentFactory = get_label_text("CELL_HCK_DEN"),

    MotorcycleClub = get_label_text("HP_GANG_MC"),
    BikerClubhouse = get_label_text("BLIP_492"),
    DocumentForgeryOffice = get_label_text("BKR_FACTORY_0"),
    WeedFarm = get_label_text("BKR_FACTORY_1"),
    CounterfeitCashFactory = get_label_text("BKR_FACTORY_2"),
    MethLab = get_label_text("BKR_FACTORY_3"),
    CocaineLockup = get_label_text("BKR_FACTORY_4"),


    LaunchMission = get_label_text("HEIST_IB_LAUNCH"),
    EliteChallenge = get_label_text("CH_END_9ST"),

    TheFleecaJob = get_label_text("HTITLE_TUT"),
    ThePrisonBreak = get_label_text("HTITLE_PRISON"),
    TheHumaneLabsRaid = get_label_text("HTITLE_HUMANE"),
    SeriesAFunding = get_label_text("HTITLE_NARC"),
    ThePacificStandardJob = get_label_text("HTITLE_ORNATE"),

    TheDataBreaches = get_label_text("HPSTRAND_IAAB"),
    TheBogdanProblem = get_label_text("HPSTRAND_SUBB"),
    TheDoomsdayScenario = get_label_text("HPSTRAND_MSILB"),

    ACT_1_DATA_BREACHES = get_label_text("CELEB_ACT_1"),
    ACT_2_BOGDAN_PROBLEM = get_label_text("CELEB_ACT_2"),
    ACT_3_DOOMSDAY_SCENARIO = get_label_text("CELEB_ACT_3"),

    TheUnionDepositoryContract = get_label_text("TUNPLAN_ROB0"),
    TheSuperdollarDeal = get_label_text("TUNPLAN_ROB1"),
    TheBankContract = get_label_text("TUNPLAN_ROB2"),
    TheECUJob = get_label_text("TUNPLAN_ROB3"),
    ThePrisonContract = get_label_text("TUNPLAN_ROB4"),
    TheAgencyDeal = get_label_text("TUNPLAN_ROB5"),
    TheLostContract = get_label_text("TUNPLAN_ROB6"),
    TheDataContract = get_label_text("TUNPLAN_ROB7"),
}

Labels.SpecialCargoWarehouse = string.format("%s %s", Labels.SpecialCargo, Labels.Warehouse)
Labels.LaunchMissionByTerrorbyte = string.format("%s (%s %s)", Labels.LaunchMission, Labels.Terrorbyte, Labels.Computer)
Labels.LaunchMissionByBunker = string.format("%s (%s %s)", Labels.LaunchMission, Labels.Bunker, Labels.Computer)
Labels.LaunchMissionByHangar = string.format("%s (%s %s)", Labels.LaunchMission, Labels.Hangar, Labels.Computer)




Lang = {
    O_W_F_INS_FIN = "仅在使用直接完成任务功能时生效",
    E_B_S_M = "确保在开始任务前启用本选项",

    SelectMission = "选择任务",
    CashReward = "收入奖励",
    MissionReward = "任务奖励",
    SetMissionReward = "设置任务奖励",
}




Tables = {
    ------------------------------------
    --    BUSINESS MISSION
    ------------------------------------

    ContrabandBuy = {
        { -1, Labels.RANDOM,              {}, "" },
        { 0,  "车辆收集",       {}, "" },
        { 1,  "移动收藏",         {}, "" },
        { 2,  "货物空投",               {}, "" },
        { 3,  "移动车辆",           {}, "" },
        { 4,  "物品协议",            {}, "" },
        { 5,  "伏击",                 {}, "" },
        { 6,  "偷窃防暴车",           {}, "" },
        { 7,  "帮派藏身处",             {}, "" },
        { 8,  "直升机击落",            {}, "" },
        { 9,  "女武神击倒",        {}, "" },
        { 10, "坠机地点",               {}, "" },
        { 11, "小偷",                    {}, "" },
        { 12, "被困",                  {}, "" },
        { 13, "后果",                {}, "" },
        { 14, "雷达",                 {}, "" },
        { 15, "刺杀",            {}, "" },
        { 16, "船只袭击",              {}, "" },
        { 17, "多辆移动车辆", {}, "" },
    },
    ContrabandSell = {
        { -1, Labels.RANDOM,    {}, "" },
        { 0,  "默认",        {}, "Single drop-off. Simple collect and deliver." },
        { 1,  "多种的",       {}, "5 drop-offs across city. Paid per location (20%)." },
        { 2,  "讽刺",          {}, "5 drop-offs across city. Paid per location (20%). One location will randomly trigger a 3 star Wanted Rating when the contraband is dropped off." },
        { 3,  "土地损害",    {}, "Buyer wants the vehicle in mint condistion.$10,000 bonus appears on screen but every small knocks damages the contraband and lowers its value slightly (player must drive carefully)." },
        { 4,  "登陆 Trackify",  {}, "Single Drop Off. Player receives text from PA saying buyer is overly cautious. Use trackify to find the drop off location." },
        { 5,  "陆上攻击",    {}, "" },
        { 6,  "土地保卫",    {}, "Contraband vehicle gets attacked after vehicle is dropped off.	" },
        { 7,  "空气低",        {}, "Drive to LSIA to collect a plane then make 5 drops across the map. Fly low to avoid detection from the cops. If you go to high you gain 3 stars and must lost the cops to continue." },
        { 8,  "空投",       {}, "Drive to LSIA to collect a plane then make 5 drops across the map." },
        { 9,  "空气洁净区", {}, "Drive to LSIA to collect a plane then take plane to the country side drop off, kill enemies at drop off." },
        { 10, "空中限制", {}, "Drive to LSIA to collect a plane, make the four drop off, last is in a restricted area, lose the cops to complete the mission." },
        { 11, "空袭",     {}, "Drive to LSIA to collect a plane then make 5 drops across the map, get attacked by AI choppers." },
        { 12, "海上攻击",     {}, "Go to the docks and collect a speeder to meet a contact out at sea. Attacked on route by AI gang peds in boats and helicopter." },
        { 13, "海上保卫战",     {}, "Go to the docks and kill enemies that are surrounding your Speeder before you get in it to meet a contact out at sea." },
    },
    ContrabandSpecialItem = {
        { -1, Labels.Default },
        { 0,  get_label_text("SRC_CRG_SP_0") }, -- Ornamental Egg
        { 1,  get_label_text("SRC_CRG_SP_1") }, -- Golden Minigun
        { 2,  get_label_text("SRC_CRG_SP_2") }, -- Extra Large Diamond
        { 3,  get_label_text("SRC_CRG_SP_3") }, -- Sasquatch Hide
        { 4,  get_label_text("SRC_CRG_SP_4") }, -- Film Reel
        { 5,  get_label_text("SRC_CRG_SP_5") }, -- Rare Pocket Watch
    },

    SmugglerBuy = {
        { -1, Labels.RANDOM,    {}, "" },
        { 0,  "夺取信标",    {}, "" },
        { 1,  "黑匣子",      {}, "" },
        { 2,  "炸弹基地",      {}, "" },
        { 3,  "轰炸行动",    {}, "" },
        { 4,  "货机",    {}, "" },
        { 5,  "炸弹屋顶",      {}, "" },
        { 6,  "板条箱追逐",    {}, "" },
        { 7,  "空战",       {}, "" },
        { 8,  "护送",         {}, "" },
        { 9,  "浸润",   {}, "" },
        { 10, "屋顶攻击",    {}, "" },
        { 11, "溅落", {}, "" },
        { 12, "偷飞机", {}, "" },
        { 13, "特技飞行员",    {}, "" },
        { 14, "热成像瞄准镜",  {}, "" },
    },
    SmugglerSell = {
        { -1, Labels.RANDOM,        {}, "" },
        { 15, "敏捷交付",     {}, "" },
        { 16, "空运",       {}, "" },
        { 17, "空中警察",         {}, "" },
        { 18, "航空转运",       {}, "" },
        { 19, "轰击",        {}, "" },
        { 20, "有争议",          {}, "" },
        { 21, "空中堡垒",    {}, "" },
        { 22, "低飞",            {}, "" },
        { 23, "繁重工作",      {}, "" },
        { 24, "精准配送", {}, "" },
        { 25, "低调",    {}, "" },
    },
    SmugglerCargoType = {
        { -1, Labels.RANDOM },
        { 0,  get_label_text("HAN_CRG_ANIMAL") }, -- Animal Materials
        { 1,  get_label_text("HAN_CRG_ART") },    -- Art & Antiques
        { 2,  get_label_text("HAN_CRG_CHEMS") },  -- Chemicals
        { 3,  get_label_text("HAN_CRG_GOODS") },  -- Counterfeit Goods
        { 4,  get_label_text("HAN_CRG_JEWEL") },  -- Jewelry & Gemstones
        { 5,  get_label_text("HAN_CRG_MEDS") },   -- Medical Supplies
        { 6,  get_label_text("HAN_CRG_NARC") },   -- Narcotics
        { 7,  get_label_text("HAN_CRG_TOBAC") },  -- Tobacco & Alcohol
        { 8,  get_label_text("HAN_CRG_MIXED") },  -- Cargo
    },
    HangarProductModelPropertyType = {
        -- Medical Supplies
        { 1,  get_label_text("HAN_CRG_MEDS") },
        { 2,  get_label_text("HAN_CRG_MEDS") },
        -- Tobacco & Alcohol
        { 3,  get_label_text("HAN_CRG_TOBAC") },
        { 4,  get_label_text("HAN_CRG_TOBAC") },
        -- Art & Antiques
        { 5,  get_label_text("HAN_CRG_ART") },
        { 6,  get_label_text("HAN_CRG_ART") },
        -- Narcotics
        { 7,  get_label_text("HAN_CRG_NARC") },
        { 8,  get_label_text("HAN_CRG_NARC") },
        -- Jewelry & Gemstones
        { 9,  get_label_text("HAN_CRG_JEWEL") },
        { 10, get_label_text("HAN_CRG_JEWEL") },
        -- Animal Materials
        { 11, get_label_text("HAN_CRG_ANIMAL") },
        { 12, get_label_text("HAN_CRG_ANIMAL") },
        -- Counterfeit Goods
        { 13, get_label_text("HAN_CRG_GOODS") },
        { 14, get_label_text("HAN_CRG_GOODS") },
        -- Chemicals
        { 15, get_label_text("HAN_CRG_CHEMS") },
        { 16, get_label_text("HAN_CRG_CHEMS") }
    },

    GunrunResupply = {
        { -1, Labels.RANDOM,     {}, "" },
        { 1,  "利他主义者",       {}, "" },
        { 2,  "摧毁卡车",  {}, "" },
        { 3,  "导流",       {}, "" },
        { 4,  "手电筒",      {}, "" },
        { 5,  "苍蝇拍",     {}, "" },
        { 6,  "竞争对手行动", {}, "" },
        { 7,  "偷装甲运兵车",       {}, "" },
        { 8,  "窃取迷你枪",  {}, "" },
        { 9,  "窃取电磁炮",  {}, "" },
        { 10, "偷犀牛坦克",     {}, "" },
        { 11, "窃取技术", {}, "" },
        { 12, "偷货车",       {}, "" },
        { 13, "游艇搜索",    {}, "" },
    },
    GunrunSell = {
        { -1, Labels.RANDOM,       {}, "" },
        { 14, "伏击",          {}, "" },
        { 15, "听从领队", {}, "" },
        { 16, "爬山",        {}, "" },
        { 17, "移动武器",      {}, "" },
        { 18, "幻影",           {}, "" },
        { 19, "崎岖地形",     {}, "" },
    },

    AcidLabSource = {
        { -1, Labels.RANDOM,        {}, "" },
        { 0,  "化学品泄漏",     {}, "" },
        { 1,  "挥发性化学物质", {}, "" },
        { 2,  "偷粮",     {}, "" },
        { 3,  "丢失空投",   {}, "" },
        { 4,  "妄想货车",     {}, "" },
    },
    AcidLabSell = {
        { -1, Labels.RANDOM,    {}, "" },
        { 0,  "送报员",       {}, "" },
        { 1,  "警察突击搜捕",   {}, "" },
        { 2,  "储藏配送", {}, "" },
    },

    NightclubSell = {
        { -1, Labels.RANDOM,       {}, "" },
        { 6,  "单滴",       {}, "" },
        { 7,  "多点投送",        {}, "" },
        { 8,  "黑客掉落",         {}, "" },
        { 9,  "障碍",         {}, "" },
        { 10, "保护买家",     {}, "" },
        { 11, "卧底警察",   {}, "" },
        { 12, "离岸转移", {}, "" },
        { 13, "一点划痕都没有",     {}, "" },
        { 14, "关注 Heli",       {}, "" },
        { 15, "寻找买家",        {}, "" },
    },

    BikerResupply = {
        { -1, Labels.RANDOM,              {}, "", "" },

        { 0,  "大麻",                {}, "", "任务选择" },
        { 1,  "易碎品",         {}, "", "任务选择" },
        { 2,  "冰毒实验室",                 {}, "", "任务选择" },
        { 3,  "杀戮贩子",                {}, "", "任务选择" },
        { 4,  "认识联系人",             {}, "", "任务选择" },
        { 5,  "杀戮贩子",             {}, "", "任务选择" },
        { 6,  "摧毁板条箱",           {}, "", "任务选择" },
        { 7,  "保安车",            {}, "", "任务选择" },
        { 8,  "修理工",                {}, "", "任务选择" },
        { 9,  "饵",                     {}, "", "任务选择" },
        { 10, "银行",                     {}, "", "任务选择" },
        { 11, "恐吓",             {}, "", "任务选择" },
        { 12, "摩托帮混战",              {}, "", "任务选择" },
        { 13, "争吵",                    {}, "", "任务选择" },
        { 14, "信号弹",             {}, "", "任务选择" },

        { 15, "大麻设置",               {}, "", "任务选择" },
        { 16, "冰毒设置",               {}, "", "任务选择" },
        { 17, "可卡因设置",               {}, "", "任务选择" },
        { 18, "假证设置",            {}, "", "任务选择" },
        { 19, "假冒设置",        {}, "", "任务选择" },

        { 20, "车辆收集",       {}, "", "任务选择" },

        { 21, "移动车辆",           {}, "", "任务选择" },
        { 22, "移动收藏",         {}, "", "任务选择" },
        { 23, "货物空投",               {}, "", "任务选择" },
        { 24, "物品协议",            {}, "", "任务选择" },
        { 25, "伏击",                 {}, "", "任务选择" },
        { 26, "扣押",                {}, "", "任务选择" },
        { 27, "偷窃防暴车",           {}, "", "任务选择" },
        { 28, "警察突击搜捕",             {}, "", "任务选择" },
        { 29, "帮派藏身处",             {}, "", "任务选择" },
        { 30, "直升机击落",            {}, "", "任务选择" },
        { 31, "女武神击倒",        {}, "", "任务选择" },
        { 32, "坠机地点",               {}, "", "任务选择" },
        { 33, "小偷",                    {}, "", "任务选择" },
        { 34, "被困",                  {}, "", "任务选择" },
        { 35, "后果",                {}, "", "任务选择" },
        { 36, "雷达",                 {}, "", "任务选择" },
        { 37, "刺杀",            {}, "", "任务选择" },
        { 38, "船只袭击",              {}, "", "任务选择" },
        { 39, "多辆移动车辆", {}, "", "任务选择" },
    },
    BikerSell = {
        { -1, Labels.RANDOM,     {}, "" },
        { 0,  "默认",         {}, "" },
        { 1,  "海上空投", {}, "" },
        { 2,  "直升机空投", {}, "" },
        { 3,  "垃圾大师",     {}, "" },
        { 4,  "患难之友", {}, "" },
        { 5,  "邮递员",         {}, "" },
        { 6,  "刺痛行动",        {}, "" },
        { 7,  "经过验证",          {}, "" },
        { 8,  "本森",          {}, "" },
        { 9,  "边境巡逻",   {}, "" },
        { 10, "行李托运",        {}, "" },
        { 11, "比赛",            {}, "" },
        { 12, "俱乐部跑步",        {}, "" },
    },

    VehicleExportSteal = {
        { -1, Labels.RANDOM,              {}, "" },
        { 0,  "车辆收集",       {}, "" },
        { 1,  "移动车辆",           {}, "" },
        { 2,  "货运直升机",                 {}, "" },
        { 3,  "醉酒司机",             {}, "" },
        { 4,  "照片拍摄",              {}, "" },
        { 5,  "图片信息",          {}, "" },
        { 6,  "犯罪现场",              {}, "" },
        { 7,  "受保护车辆",        {}, "" },
        { 8,  "卖车",                     {}, "" },
        { 9,  "不速之客",            {}, "" },
        { 10, "汽车见面会",                 {}, "" },
        { 11, "警察追捕",             {}, "" },
        { 12, "天空之眼",           {}, "" },
        { 13, "拆弹",              {}, "" },
        { 14, "圈速",              {}, "" },
        { 15, "特技演员",                {}, "" },
        { 16, "赛车手",              {}, "" },
        { 17, "尾车",             {}, "" },

        { 18, "移动收藏",         {}, "", "任务选择" },
        { 19, "货物空投",               {}, "", "任务选择" },
        { 20, "物品协议",            {}, "", "任务选择" },
        { 21, "伏击",                 {}, "", "任务选择" },
        { 22, "扣押",                {}, "", "任务选择" },
        { 23, "偷窃防暴车",           {}, "", "任务选择" },
        { 24, "机场突击搜捕",             {}, "", "任务选择" },
        { 25, "帮派藏身处",             {}, "", "任务选择" },
        { 26, "直升机击落",            {}, "", "任务选择" },
        { 27, "女武神击倒",        {}, "", "任务选择" },
        { 28, "坠机地点",               {}, "", "任务选择" },
        { 29, "小偷",                    {}, "", "任务选择" },
        { 30, "被困",                  {}, "", "任务选择" },
        { 30, "后果",                {}, "", "任务选择" },
        { 30, "雷达",                 {}, "", "任务选择" },
        { 30, "刺杀",            {}, "", "任务选择" },
        { 30, "船只袭击",              {}, "", "任务选择" },
        { 30, "多辆移动车辆", {}, "", "任务选择" },
    },
    VehicleExportEnum = {
        { -1, Labels.Default },
        -- Molten Metal Collector: Ronnie Bonelli
        { 28, get_label_text("IE_VEH_ALPHA_1"),      {}, "", get_label_text("IEW_COLLECTION_METAL") },
        { 23, get_label_text("IE_VEH_REAPER_2"),     {}, "", get_label_text("IEW_COLLECTION_METAL") },
        { 90, get_label_text("IE_VEH_MASSACRO_3"),   {}, "", get_label_text("IEW_COLLECTION_METAL") },
        { 55, get_label_text("IE_VEH_ZENTORNO_1"),   {}, "", get_label_text("IEW_COLLECTION_METAL") },
        -- Birds of Paradise Collector: Curtis Cray Esq
        { 76, get_label_text("IE_VEH_CHEETAH_1"),    {}, "", get_label_text("IEW_COLLECTION_TROPICAL") },
        { 4,  get_label_text("IE_VEH_TYRUS_1"),      {}, "", get_label_text("IEW_COLLECTION_TROPICAL") },
        { 19, get_label_text("IE_VEH_FMJ_1"),        {}, "", get_label_text("IEW_COLLECTION_TROPICAL") },
        { 50, get_label_text("IE_VEH_ENTITYXF_2"),   {}, "", get_label_text("IEW_COLLECTION_TROPICAL") },
        -- Shades of Blue Collector: Cris Formage
        { 82, get_label_text("IE_VEH_BANSHEE2_1"),   {}, "", get_label_text("IEW_COLLECTION_ELEGANT") },
        { 42, get_label_text("IE_VEH_FELTZER3_3"),   {}, "", get_label_text("IEW_COLLECTION_ELEGANT") },
        { 65, get_label_text("IE_VEH_SEVEN70_2"),    {}, "", get_label_text("IEW_COLLECTION_ELEGANT") },
        { 87, get_label_text("IE_VEH_TURISMOR_3"),   {}, "", get_label_text("IEW_COLLECTION_ELEGANT") },
        -- Hip to be Square Collector: Tao Cheng
        { 59, get_label_text("IE_VEH_OMNIS_2"),      {}, "", get_label_text("IEW_COLLECTION_RALLY") },
        { 48, get_label_text("IE_VEH_TROPOS_3"),     {}, "", get_label_text("IEW_COLLECTION_RALLY") },
        { 96, get_label_text("IE_VEH_JESTER_3"),     {}, "", get_label_text("IEW_COLLECTION_RALLY") },
        { 52, get_label_text("IE_VEH_SULTANRS_1"),   {}, "", get_label_text("IEW_COLLECTION_RALLY") },
        -- Pastel Perfection Collector: Cloe Parker
        { 73, get_label_text("IE_VEH_COQUETTE2_1"),  {}, "", get_label_text("IEW_COLLECTION_PRETTY") },
        { 67, get_label_text("IE_VEH_VERLIERER2_1"), {}, "", get_label_text("IEW_COLLECTION_PRETTY") },
        { 15, get_label_text("IE_VEH_SHEAVA_3"),     {}, "", get_label_text("IEW_COLLECTION_PRETTY") },
        -- Stay Declasse Collector: Ms. M Schultz
        { 93, get_label_text("IE_VEH_SABREGT2_3"),   {}, "", get_label_text("IEW_COLLECTION_DECLASSE") },
        { 34, get_label_text("IE_VEH_TAMPA_1"),      {}, "", get_label_text("IEW_COLLECTION_DECLASSE") },
        { 32, get_label_text("IE_VEH_MAMBA_2"),      {}, "", get_label_text("IEW_COLLECTION_DECLASSE") },
        -- Uninsurable Collector: Jay Norris
        { 2,  get_label_text("IE_VEH_PROTOTIPO_2"),  {}, "", get_label_text("IEW_COLLECTION_DANGEROUS") },
        { 12, get_label_text("IE_VEH_T20_3"),        {}, "", get_label_text("IEW_COLLECTION_DANGEROUS") },
        { 18, get_label_text("IE_VEH_OSIRIS_3"),     {}, "", get_label_text("IEW_COLLECTION_DANGEROUS") },
        -- No Direct Sunlight Collector: DJ Playlist
        { 70, get_label_text("IE_VEH_FELTZER2_1"),   {}, "", get_label_text("IEW_COLLECTION_MATTE") },
        { 27, get_label_text("IE_VEH_PFISTER811_3"), {}, "", get_label_text("IEW_COLLECTION_MATTE") },
        { 7,  get_label_text("IE_VEH_BESTIAGTS_1"),  {}, "", get_label_text("IEW_COLLECTION_MATTE") },
        -- Fading Power Collector: Keith Collins MD
        { 61, get_label_text("IE_VEH_COQUETTE3_1"),  {}, "", get_label_text("IEW_COLLECTION_MUSCULAR") },
        { 80, get_label_text("IE_VEH_NIGHTSHADE_2"), {}, "", get_label_text("IEW_COLLECTION_MUSCULAR") },
        -- End Of Empires Collector: The Sultan of Amir
        { 43, get_label_text("IE_VEH_ZTYPE_1"),      {}, "", get_label_text("IEW_COLLECTION_WEALTHY") },
        { 38, get_label_text("IE_VEH_BTYPE3_2"),     {}, "", get_label_text("IEW_COLLECTION_WEALTHY") },


        { 1,  get_label_text("IE_VEH_PROTOTIPO_1"),  {}, "", "" },
        { 3,  get_label_text("IE_VEH_PROTOTIPO_3"),  {}, "", "" },
        { 5,  get_label_text("IE_VEH_TYRUS_2"),      {}, "", "" },
        { 6,  get_label_text("IE_VEH_TYRUS_3"),      {}, "", "" },
        { 8,  get_label_text("IE_VEH_BESTIAGTS_2"),  {}, "", "" },
        { 9,  get_label_text("IE_VEH_BESTIAGTS_3"),  {}, "", "" },
        { 10, get_label_text("IE_VEH_T20_1"),        {}, "", "" },
        { 11, get_label_text("IE_VEH_T20_2"),        {}, "", "" },
        { 13, get_label_text("IE_VEH_SHEAVA_1"),     {}, "", "" },
        { 14, get_label_text("IE_VEH_SHEAVA_2"),     {}, "", "" },
        { 16, get_label_text("IE_VEH_OSIRIS_1"),     {}, "", "" },
        { 17, get_label_text("IE_VEH_OSIRIS_2"),     {}, "", "" },
        { 20, get_label_text("IE_VEH_FMJ_2"),        {}, "", "" },
        { 21, get_label_text("IE_VEH_FMJ_3"),        {}, "", "" },
        { 22, get_label_text("IE_VEH_REAPER_1"),     {}, "", "" },
        { 24, get_label_text("IE_VEH_REAPER_3"),     {}, "", "" },
        { 25, get_label_text("IE_VEH_PFISTER811_1"), {}, "", "" },
        { 26, get_label_text("IE_VEH_PFISTER811_2"), {}, "", "" },
        { 29, get_label_text("IE_VEH_ALPHA_2"),      {}, "", "" },
        { 30, get_label_text("IE_VEH_ALPHA_3"),      {}, "", "" },
        { 31, get_label_text("IE_VEH_MAMBA_1"),      {}, "", "" },
        { 33, get_label_text("IE_VEH_MAMBA_3"),      {}, "", "" },
        { 35, get_label_text("IE_VEH_TAMPA_2"),      {}, "", "" },
        { 36, get_label_text("IE_VEH_TAMPA_3"),      {}, "", "" },
        { 37, get_label_text("IE_VEH_BTYPE3_1"),     {}, "", "" },
        { 39, get_label_text("IE_VEH_BTYPE3_3"),     {}, "", "" },
        { 40, get_label_text("IE_VEH_FELTZER3_1"),   {}, "", "" },
        { 41, get_label_text("IE_VEH_FELTZER3_2"),   {}, "", "" },
        { 44, get_label_text("IE_VEH_ZTYPE_2"),      {}, "", "" },
        { 45, get_label_text("IE_VEH_ZTYPE_3"),      {}, "", "" },
        { 46, get_label_text("IE_VEH_TROPOS_1"),     {}, "", "" },
        { 47, get_label_text("IE_VEH_TROPOS_2"),     {}, "", "" },
        { 49, get_label_text("IE_VEH_ENTITYXF_1"),   {}, "", "" },
        { 51, get_label_text("IE_VEH_ENTITYXF_3"),   {}, "", "" },
        { 53, get_label_text("IE_VEH_SULTANRS_2"),   {}, "", "" },
        { 54, get_label_text("IE_VEH_SULTANRS_3"),   {}, "", "" },
        { 56, get_label_text("IE_VEH_ZENTORNO_2"),   {}, "", "" },
        { 57, get_label_text("IE_VEH_ZENTORNO_3"),   {}, "", "" },
        { 58, get_label_text("IE_VEH_OMNIS_1"),      {}, "", "" },
        { 60, get_label_text("IE_VEH_OMNIS_3"),      {}, "", "" },
        { 62, get_label_text("IE_VEH_COQUETTE3_2"),  {}, "", "" },
        { 63, get_label_text("IE_VEH_COQUETTE3_3"),  {}, "", "" },
        { 64, get_label_text("IE_VEH_SEVEN70_1"),    {}, "", "" },
        { 66, get_label_text("IE_VEH_SEVEN70_3"),    {}, "", "" },
        { 68, get_label_text("IE_VEH_VERLIERER2_2"), {}, "", "" },
        { 69, get_label_text("IE_VEH_VERLIERER2_3"), {}, "", "" },
        { 71, get_label_text("IE_VEH_FELTZER2_2"),   {}, "", "" },
        { 72, get_label_text("IE_VEH_FELTZER2_3"),   {}, "", "" },
        { 74, get_label_text("IE_VEH_COQUETTE2_2"),  {}, "", "" },
        { 75, get_label_text("IE_VEH_COQUETTE2_3"),  {}, "", "" },
        { 77, get_label_text("IE_VEH_CHEETAH_2"),    {}, "", "" },
        { 78, get_label_text("IE_VEH_CHEETAH_3"),    {}, "", "" },
        { 79, get_label_text("IE_VEH_NIGHTSHADE_1"), {}, "", "" },
        { 81, get_label_text("IE_VEH_NIGHTSHADE_3"), {}, "", "" },
        { 83, get_label_text("IE_VEH_BANSHEE2_2"),   {}, "", "" },
        { 84, get_label_text("IE_VEH_BANSHEE2_3"),   {}, "", "" },
        { 85, get_label_text("IE_VEH_TURISMOR_1"),   {}, "", "" },
        { 86, get_label_text("IE_VEH_TURISMOR_2"),   {}, "", "" },
        { 88, get_label_text("IE_VEH_MASSACRO_1"),   {}, "", "" },
        { 89, get_label_text("IE_VEH_MASSACRO_2"),   {}, "", "" },
        { 91, get_label_text("IE_VEH_SABREGT2_1"),   {}, "", "" },
        { 92, get_label_text("IE_VEH_SABREGT2_2"),   {}, "", "" },
        { 94, get_label_text("IE_VEH_JESTER_1"),     {}, "", "" },
        { 95, get_label_text("IE_VEH_JESTER_2"),     {}, "", "" },
    },

    BikerFactory = {
        { 0, Labels.DocumentForgeryOffice },
        { 1, Labels.WeedFarm },
        { 2, Labels.CounterfeitCashFactory },
        { 3, Labels.MethLab },
        { 4, Labels.CocaineLockup }
    },


    ------------------------------------
    --    BUSINESS
    ------------------------------------

    NightclubGoodsName = {
        [0] = get_label_text("CLUB_STOCK0"), -- Cargo and Shipments
        [1] = get_label_text("CLUB_STOCK1"), -- Sporting Goods
        [2] = get_label_text("CLUB_STOCK2"), -- South American Imports
        [3] = get_label_text("CLUB_STOCK3"), -- Pharmaceutical Research
        [4] = get_label_text("CLUB_STOCK4"), -- Organic Produce
        [5] = get_label_text("CLUB_STOCK5"), -- Printing & Copying
        [6] = get_label_text("CLUB_STOCK6")  -- Cash Creation
    },
    BikerFactoryName = {
        [0] = Labels.DocumentForgeryOffice,
        [1] = Labels.WeedFarm,
        [2] = Labels.CounterfeitCashFactory,
        [3] = Labels.MethLab,
        [4] = Labels.CocaineLockup
    },
    BikerFactoryType = {
        -- [FACTORY_ID]
        [1]  = 3, -- FACTORY_TYPE_METH
        [2]  = 1, -- FACTORY_TYPE_WEED
        [3]  = 4, -- FACTORY_TYPE_CRACK
        [4]  = 2, -- FACTORY_TYPE_FAKE_MONEY
        [5]  = 0, -- FACTORY_TYPE_FAKE_IDS

        [6]  = 3,
        [7]  = 1,
        [8]  = 4,
        [9]  = 2,
        [10] = 0,

        [11] = 3,
        [12] = 1,
        [13] = 4,
        [14] = 2,
        [15] = 0,

        [16] = 3,
        [17] = 1,
        [18] = 4,
        [19] = 2,
        [20] = 0
    },
    HangarGoodsName = {
        [0] = get_label_text("HAN_CRG_ANIMAL"), -- Animal Materials
        [1] = get_label_text("HAN_CRG_ART"),    -- Art & Antiques
        [2] = get_label_text("HAN_CRG_CHEMS"),  -- Chemicals
        [3] = get_label_text("HAN_CRG_GOODS"),  -- Counterfeit Goods
        [4] = get_label_text("HAN_CRG_JEWEL"),  -- Jewelry & Gemstones
        [5] = get_label_text("HAN_CRG_MEDS"),   -- Medical Supplies
        [6] = get_label_text("HAN_CRG_NARC"),   -- Narcotics
        [7] = get_label_text("HAN_CRG_TOBAC"),  -- Tobacco & Alcohol
        -- [8] = get_label_text("HAN_CRG_MIXED"),  -- Cargo
    },
    HangaModelIndexGoodType = {
        [1] = 5,
        [2] = 5,
        [3] = 7,
        [4] = 7,
        [5] = 1,
        [6] = 1,
        [7] = 6,
        [8] = 6,
        [9] = 4,
        [10] = 4,
        [11] = 0,
        [12] = 0,
        [13] = 3,
        [14] = 3,
        [15] = 2,
        [16] = 2,
    },


    ------------------------------------
    --    FREEMODE MISSION
    ------------------------------------

    SecurityContract = {
        { -1, Labels.RANDOM },
        { 0,  get_label_text("FXR_STSTART_RP") }, -- FSV_RECOVERY_PACKAGE
        { 1,  get_label_text("FXR_STSTART_RV") }, -- FSV_RECOVERY_VEHICLE
        { 2,  get_label_text("FXR_STSTART_AS") }, -- FSV_RECOVERY_ASSAULT
        { 3,  get_label_text("FXR_STSTART_RE") }, -- FSV_RECOVERY_RESCUE
        { 4,  get_label_text("FXR_STSTART_PR") }, -- FSV_RECOVERY_PROTECT
        { 5,  get_label_text("FXR_STSTART_TD") }, -- FSV_RECOVERY_TAIL
    },
    SecurityContractDifficulty = {
        { -1, Labels.RANDOM },
        { 0,  get_label_text("FAPP_NORMAL") }, -- FSCD_DEFAULT
        { 1,  get_label_text("FAPP_HARD") },   -- FSCD_HARD
        { 2,  get_label_text("FAPP_VERSUS") }, -- FSCD_HARD_WITH_RIVALS
    },

    PayphoneHit = {
        { -1, Labels.RANDOM },
        { 0,  get_label_text("FXR_OT_TAR1") }, -- FPV_TAXI
        { 1,  get_label_text("FXR_OT_TAR2") }, -- FPV_GOLF
        { 2,  get_label_text("FXR_OT_TAR3") }, -- FPV_MOTEL
        { 3,  get_label_text("FXR_OT_TAR5") }, -- FPV_HIT_LIST
        { 4,  get_label_text("FXR_OT_TAR7") }, -- FPV_COORD_ATTACK
        { 5,  get_label_text("FXR_OT_TAR4") }, -- FPV_CONSTRUCTION
        { 6,  get_label_text("FXR_OT_TAR6") }, -- FPV_JOYRIDER
        { 7,  get_label_text("FXR_OT_TAR8") }, -- FPV_APPROACH
    },

    ClubSource = {
        { -1, Labels.RANDOM },
        { 0,  "拖船" },
        { 1,  "卡车" },
    },
    GoodsType = {
        { -1, Labels.Default },
        { 0,  get_label_text("CLUB_STOCK0"), {}, get_label_text("HAPP_BTYPE_HP0") }, -- BUSINESS_TYPE_CARGO
        { 1,  get_label_text("CLUB_STOCK1"), {}, get_label_text("HAPP_BTYPE_HP1") }, -- BUSINESS_TYPE_WEAPONS
        { 2,  get_label_text("CLUB_STOCK2"), {}, get_label_text("HAPP_BTYPE_HP2") }, -- BUSINESS_TYPE_COKE
        { 3,  get_label_text("CLUB_STOCK3"), {}, get_label_text("HAPP_BTYPE_HP3") }, -- BUSINESS_TYPE_METH
        { 4,  get_label_text("CLUB_STOCK4"), {}, get_label_text("HAPP_BTYPE_HP4") }, -- BUSINESS_TYPE_WEED
        { 5,  get_label_text("CLUB_STOCK5"), {}, get_label_text("HAPP_BTYPE_HP5") }, -- BUSINESS_TYPE_FORGED_DOCS
        { 6,  get_label_text("CLUB_STOCK6"), {}, get_label_text("HAPP_BTYPE_HP6") }, -- BUSINESS_TYPE_COUNTERFEIT_CASH
    },

    ClientJobs = {
        { 242, get_label_text("HT_BW_T0"), {}, "" }, -- Robbery in Progress, FMMC_TYPE_FMBB_BANK_JOB
        { 244, get_label_text("HT_BW_T1"), {}, "" }, -- Data Sweep, FMMC_TYPE_FMBB_DATA_HACK
        { 248, get_label_text("HT_BW_T2"), {}, "" }, -- Targeted Data, FMMC_TYPE_FMBB_INFILTRATION
        { 241, get_label_text("HT_BW_T3"), {}, "" }, -- Diamond Shopping, FMMC_TYPE_FMBB_JEWEL_STORE_GRAB
    },

    DrugLabWork = {
        { -1, Labels.RANDOM,  {}, "" },
        { 0,  "Crop Dusting", {}, "" },
        { 1,  "Weed Farm",    {}, "" },
        { 2,  "Vehicle Bomb", {}, "" },
        { 3,  "Supply Line",  {}, "" },
        { 4,  "Drug Lord",    {}, "" },
    },
    CasinoWork = {
        { -1, Labels.RANDOM,                {}, "" },
        { 0,  get_label_text("GBC_ST_BP"),  {}, "" }, -- CSV_BAD_PRESS
        { 1,  get_label_text("GBC_ST_BD"),  {}, "" }, -- CSV_BODY_DISPOSAL
        { 2,  get_label_text("GBC_ST_CC"),  {}, "" }, -- CSV_COUNTERFEIT_CHIPS
        { 3,  get_label_text("GBC_ST_DC"),  {}, "" }, -- CSV_DEFEND_CASINO
        { 4,  get_label_text("GBC_ST_ED"),  {}, "" }, -- CSV_ESCORT_DUTY
        { 5,  get_label_text("GBC_ST_HE"),  {}, "" }, -- CSV_HEISTERS
        { 6,  get_label_text("GBC_ST_HR"),  {}, "" }, -- CSV_HIGH_ROLLER
        { 7,  get_label_text("GBC_ST_HRT"), {}, "" }, -- CSV_HIGH_ROLLER_TOUR
        { 8,  get_label_text("GBC_ST_IJ"),  {}, "" }, -- CSV_INTIMIDATE_JUDGE
        { 9,  get_label_text("GBC_ST_MD"),  {}, "" }, -- CSV_MISSING_DELIVERY
        { 10, get_label_text("GBC_ST_PO"),  {}, "" }, -- CSV_PASSED_OUT
        { 11, get_label_text("GBC_ST_RLC"), {}, "" }, -- CSV_RECOVER_LUXURY_CAR
        { 12, get_label_text("GBC_ST_SM"),  {}, "" }, -- CSV_SLOT_MACHINES
        { 13, get_label_text("GBC_ST_SP"),  {}, "" }, -- CSV_STAFF_PROBLEMS
        { 14, get_label_text("GBC_ST_TC"),  {}, "" }, -- CSV_TRACKING_CHIPS
        { 15, get_label_text("GBC_ST_UTI"), {}, "" }, -- CSV_UNDER_THE_INFLUENCE
    },
    SmugglerOperation = {
        { -1, Labels.RANDOM,                   {}, "" },
        { 0,  get_label_text("AOT_SMU_MIS_1"), {}, "" },
        { 1,  get_label_text("AOT_SMU_MIS_2"), {}, "" },
        { 2,  get_label_text("AOT_SMU_MIS_3"), {}, "" },
    },

    SalvageYardRobbery = {
        { 0, get_label_text("SAL23_ENDS_R0"), {}, "" },
        { 1, get_label_text("SAL23_ENDS_R1"), {}, "" },
        { 2, get_label_text("SAL23_ENDS_R2"), {}, "" },
        { 3, get_label_text("SAL23_ENDS_R3"), {}, "" },
        { 4, get_label_text("SAL23_ENDS_R4"), {}, "" },
    },

    FIBFiles = {
        { -1, Labels.None },
        { 0,  get_label_text("HF_BMPS_4") }, -- The Black Box File
        { 1,  get_label_text("HF_BMPS_2") }, -- The Brute Force File
        { 2,  get_label_text("HF_BMPS_1") }, -- The Fine Art File
        { 3,  get_label_text("HF_BMPS_3") }, -- The Project Breakaway File
    },


    ------------------------------------
    --    FREEMODE PREP
    ------------------------------------

    FixerVIP = {
        { -1, Labels.RANDOM },
        { 0,  get_label_text("FXR_BM_VC_T_S") },                                           -- FVV_SETUP
        { 1,  get_label_text("FIX_APP_DATA_L1_T1"), {}, get_label_text("FIX_APP_DL1_T") }, -- FVV_NIGHTCLUB
        { 2,  get_label_text("FIX_APP_DATA_L1_T2"), {}, get_label_text("FIX_APP_DL1_T") }, -- FVV_YACHT
        { 3,  get_label_text("FIX_APP_DATA_L2_T1"), {}, get_label_text("FIX_APP_DL2_T") }, -- FVV_LIMO
        { 4,  get_label_text("FIX_APP_DATA_L2_T2"), {}, get_label_text("FIX_APP_DL2_T") }, -- FVV_WAY_IN
        { 5,  get_label_text("FIX_APP_DATA_L3_T1"), {}, get_label_text("FIX_APP_DL3_T") }, -- FVV_FAMILIES
        { 6,  get_label_text("FIX_APP_DATA_L3_T2"), {}, get_label_text("FIX_APP_DL3_T") }, -- FVV_BALLAS
    },


    ------------------------------------
    --    HEIST
    ------------------------------------

    ------------------------
    -- Auto Shop Robbery
    ------------------------

    TunerRobberyPreps = {
        { -1, Labels.RANDOM },
        { 0,  get_label_text("TR_STSTART_STP"), {}, "", get_label_text("TR_STSTART_T2") },   -- TRV_SETUP
        { 1,  get_label_text("TR_STSTART_EP"),  {}, "", Labels.TheUnionDepositoryContract }, -- TRV_ELEVATOR_PASS
        { 2,  get_label_text("TR_STSTART_VK"),  {}, "", Labels.TheUnionDepositoryContract }, -- TRV_VAULT_KEY_CODES
        { 3,  get_label_text("TR_STSTART_ST"),  {}, "", Labels.TheSuperdollarDeal },         -- TRV_SCOPE_TRANSPORTER
        { 4,  get_label_text("TR_STSTART_CV"),  {}, "", Labels.TheSuperdollarDeal },         -- TRV_COMPUTER_VIRUS
        { 5,  get_label_text("TR_STSTART_TC"),  {}, "", Labels.TheBankContract },            -- TRV_THERMAL_CHARGES
        { 6,  get_label_text("TR_STSTART_SJ"),  {}, "", Labels.TheBankContract },            -- TRV_SIGNAL_JAMMERS
        { 7,  get_label_text("TR_STSTART_CM"),  {}, "", Labels.TheECUJob },                  -- TRV_CONTAINER_MANIFEST
        { 8,  get_label_text("TR_STSTART_TS"),  {}, "", Labels.TheECUJob },                  -- TRV_TRAIN_SCHEDULE
        { 9,  get_label_text("TR_STSTART_IM"),  {}, "", Labels.ThePrisonContract },          -- TRV_INSIDE_MAN
        { 10, get_label_text("TR_STSTART_SR"),  {}, "", Labels.ThePrisonContract },          -- TRV_STUNT_RAMP
        { 11, get_label_text("TR_STSTART_IA"),  {}, "", Labels.TheAgencyDeal },              -- TRV_IAA_PASS
        { 12, get_label_text("TR_STSTART_SS"),  {}, "", Labels.TheAgencyDeal },              -- TRV_SEWER_SCHEMATICS
        { 13, get_label_text("TR_STSTART_ML"),  {}, "", Labels.TheLostContract },            -- TRV_METH_LAB_LOCATIONS
        { 14, get_label_text("TR_STSTART_MT"),  {}, "", Labels.TheLostContract },            -- TRV_METH_TANKER
        { 15, get_label_text("TR_STSTART_LB"),  {}, "", Labels.TheDataContract },            -- TRV_LOCATE_BUNKER
        { 16, get_label_text("TR_STSTART_WD"),  {}, "", Labels.TheDataContract },            -- TRV_WAREHOUSE_DEFENCES
    },
    TunerRobberyFinal = {
        { -1, Labels.None },
        { 0,  Labels.TheUnionDepositoryContract },
        { 1,  Labels.TheSuperdollarDeal },
        { 2,  Labels.TheBankContract },
        { 3,  Labels.TheECUJob },
        { 4,  Labels.ThePrisonContract },
        { 5,  Labels.TheAgencyDeal },
        { 6,  Labels.TheLostContract },
        { 7,  Labels.TheDataContract }
    },
    TunerRobberyFinalRootContent = {
        { 2064133602,  Labels.TheUnionDepositoryContract }, -- TR_UNION_DEPOSITORY
        { 1364299584,  Labels.TheSuperdollarDeal },         -- TR_MILITARY_CONVOY
        { 14434931,    Labels.TheBankContract },            -- TR_FLEECA_BANK
        { 808119513,   Labels.TheECUJob },                  -- TR_FREIGHT_TRAIN
        { -554734818,  Labels.ThePrisonContract },          -- TR_BOLINGBROKE
        { -1750247281, Labels.TheAgencyDeal },              -- TR_IAA_RAID
        { 1767266297,  Labels.TheLostContract },            -- TR_METH_JOB
        { -1931849607, Labels.TheDataContract }             -- TR_BUNKER
    },

    ------------------------
    -- Apartment Heist
    ------------------------

    HeistAwards = {
        { 1, get_label_text("AWT_777") }, -- All In Order
        { 2, get_label_text("AWT_778") }, -- Loyalty
        { 3, get_label_text("AWT_779") }, -- Criminal Mastermind
        { 4, get_label_text("AWT_785") }, -- Another Perspective
        { 5, get_label_text("AWT_786") }  -- Supporting Role
    },
    HeistAwardsStats = {
        -- ProgressBitset, AwardBool
        [1] = { "MPPLY_HEISTFLOWORDERPROGRESS", "MPPLY_AWD_HST_ORDER" },
        [2] = { "MPPLY_HEISTTEAMPROGRESSBITSET", "MPPLY_AWD_HST_SAME_TEAM" },
        [3] = { "MPPLY_HEISTNODEATHPROGREITSET", "MPPLY_AWD_HST_ULT_CHAL" },
        [4] = { "MPPLY_HEIST_1STPERSON_PROG", "MPPLY_AWD_COMPLET_HEIST_1STPER" },
        [5] = { "MPPLY_HEISTMEMBERPROGRESSBITSET", "MPPLY_AWD_COMPLET_HEIST_MEM" }
    },

    HeistFinalName = {
        [-1072870761] = Labels.TheFleecaJob,
        [979654579] = Labels.ThePrisonBreak,
        [-1096986654] = Labels.TheHumaneLabsRaid,
        [164435858] = Labels.SeriesAFunding,
        [1309288309] = Labels.ThePacificStandardJob,
    },
    HeistPrepRootContentIDList = {
        -- The Fleeca Job
        [0] = "hK5OgJk1BkinXGGXghhTMg",
        [1] = "V7yEdnL6TEyU3i-U1Rv_pQ",
        -- The Prison Break
        [2] = "7-w96-PU4kSevhtG5YwUHQ",
        [3] = "oSXhVwaHH0KDOzg0rfIj3Q",
        [4] = "QS6WYcjJFk2YxqYDMN8mjQ",
        [5] = "JJ9OzPbPo02eQbaniO8E3g",
        -- The Humane Labs Raid
        [6] = "BWsCWtmnvEWXBrprK9hDHA",
        [7] = "6k6LOpnf2E-GG38OhjS-TA",
        [8] = "qRsMyKTHCEaL0qJQJR7JKQ",
        [9] = "ciWN4gwmakid4lW-nSllcA",
        [10] = "v-8OOQYzxE-Zvqj5xO03DQ",
        -- Series A Funding
        [11] = "20Lu41Px20OJMPdZ6wXG3g",
        [12] = "6UzZkstFeEeCkvs2lrF_6A",
        [13] = "kNqG_EaEpUm-F411W5AyIQ",
        [14] = "z49DSS9db0i_vh6A2e-Q-g",
        [15] = "Fo168mMjCUCeN_IKmL4VnA",
        -- The Pacific Standard Job
        [16] = "zCxFg29teE2ReKGnr0L4Bg",
        [17] = "6ClY8ZA_DkuBUdZ_fPn6Rw",
        [18] = "OiSO3Z0YdkCaEqVHhhkj4Q",
        [19] = "Cy2OZSwCt0-mSXY00o4SNw",
        [20] = "Y4zpRQDfvkawfFDR1Uxi2A",
    },
    HeistPrepList = {
        { -1, Labels.None },

        { 0, "全福银行差事: 探查", {}, "", Labels.TheFleecaJob },
        { 1, "全福银行差事: 骷髅马", {}, "", Labels.TheFleecaJob },

        { 2, "越狱: 飞机", {}, "", Labels.ThePrisonBreak },
        { 3, "越狱: 巴士", {}, "", Labels.ThePrisonBreak },
        { 4, "越狱: 警察局", {}, "", Labels.ThePrisonBreak },
        { 5, "越狱: 行刺", {}, "", Labels.ThePrisonBreak },

        { 6, "突袭人道研究实验室: 关键密码", {}, "", Labels.TheHumaneLabsRaid },
        { 7, "突袭人道研究实验室: 叛乱分子", {}, "", Labels.TheHumaneLabsRaid },
        { 8, "突袭人道研究实验室: 电磁脉冲装置", {}, "", Labels.TheHumaneLabsRaid },
        { 9, "突袭人道研究实验室: 女武神", {}, "", Labels.TheHumaneLabsRaid },
        { 10, "突袭人道研究实验室: 运送电磁脉冲装置", {}, "", Labels.TheHumaneLabsRaid },

        { 11, "首轮募资: 可卡因", {}, "", Labels.SeriesAFunding },
        { 12, "首轮募资: 垃圾车", {}, "", Labels.SeriesAFunding },
        { 13, "首轮募资: 摩托车手", {}, "", Labels.SeriesAFunding },
        { 14, "首轮募资: 大麻", {}, "", Labels.SeriesAFunding },
        { 15, "首轮募资: 窃取冰毒", {}, "", Labels.SeriesAFunding },

        { 16, "太平洋标准银行: 厢型车", {}, "", Labels.ThePacificStandardJob },
        { 17, "太平洋标准银行: 信号", {}, "", Labels.ThePacificStandardJob },
        { 18, "太平洋标准银行: 破解", {}, "", Labels.ThePacificStandardJob },
        { 19, "太平洋标准银行: 车队", {}, "", Labels.ThePacificStandardJob },
        { 20, "太平洋标准银行: 摩托车", {}, "", Labels.ThePacificStandardJob },
    },

    HeistFinalContentID = {
        [1] = "_T5Vz_ZV2kiIdfzRP3fJYQ",
        [2] = "ISSREsbrtUGrxSiLmlUCRA",
        [3] = "82ihljX03UO9tTUoLbukSQ",
        [4] = "qr5DtZrmrkGad_9pemY39g",
        [5] = "tYc3SkqXTk6ia7j0lezrbQ"
    },

    ------------------------
    -- Doomsday Heist
    ------------------------

    GangopsAwards = {
        { 1, get_label_text("AWD_GANGOPA") },  -- All In Order II
        { 2, get_label_text("AWD_GANGOPL2") }, -- Loyalty II
        { 3, get_label_text("AWD_GANGOPL3") }, -- Loyalty III
        { 4, get_label_text("AWD_GANGOPL4") }, -- Loyalty IV
        { 5, get_label_text("AWD_GANGOPM2") }, -- Criminal Mastermind II
        { 6, get_label_text("AWD_GANGOPM3") }, -- Criminal Mastermind III
        { 7, get_label_text("AWD_GANGOPM4") }, -- Criminal Mastermind IV
        { 8, get_label_text("AWD_GANGOPSR") }  -- Supporting Role II
    },
    GangopsAwardsStats = {
        -- ProgressBitset, AwardBool
        [1] = { "MPPLY_GANGOPS_ALLINORDER", "MPPLY_AWD_GANGOPS_ALLINORDER" },
        [2] = { "MPPLY_GANGOPS_LOYALTY2", "MPPLY_AWD_GANGOPS_LOYALTY2" },
        [3] = { "MPPLY_GANGOPS_LOYALTY3", "MPPLY_AWD_GANGOPS_LOYALTY3" },
        [4] = { "MPPLY_GANGOPS_LOYALTY", "MPPLY_AWD_GANGOPS_LOYALTY" },
        [5] = { "MPPLY_GANGOPS_CRIMMASMD2", "MPPLY_AWD_GANGOPS_CRIMMASMD2" },
        [6] = { "MPPLY_GANGOPS_CRIMMASMD3", "MPPLY_AWD_GANGOPS_CRIMMASMD3" },
        [7] = { "MPPLY_GANGOPS_CRIMMASMD", "MPPLY_AWD_GANGOPS_CRIMMASMD" },
        [8] = { "MPPLY_GANGOPS_SUPPORT", "MPPLY_AWD_GANGOPS_SUPPORT" }
    },

    DoomsdayHeistFinal = {
        { -1, Labels.None },
        { 0,  Labels.TheDataBreaches },
        { 1,  Labels.TheBogdanProblem },
        { 2,  Labels.TheDoomsdayScenario }
    },

    DoomsdayHeistPrepListData = {
        { menu = "divider", name = get_label_text("CELEB_ACT_1") },
        { menu = "toggle",  name = get_label_text("HPPREP_MIS_0"),  bit = 0,  help_text = "" },
        { menu = "toggle",  name = get_label_text("HPPREP_MIS_1"),  bit = 1,  help_text = "" },
        { menu = "toggle",  name = get_label_text("HPPREP_MIS_2"),  bit = 2,  help_text = "" },

        { menu = "divider", name = get_label_text("CELEB_ACT_2") },
        { menu = "toggle",  name = get_label_text("HPPREP_MIS_3"),  bit = 3,  help_text = "" },
        { menu = "toggle",  name = get_label_text("HPPREP_MIS_4"),  bit = 4,  help_text = "" },
        { menu = "toggle",  name = get_label_text("HPPREP_MIS_5"),  bit = 5,  help_text = "" },
        { menu = "toggle",  name = get_label_text("HPPREP_MIS_6"),  bit = 6,  help_text = "" },
        { menu = "toggle",  name = get_label_text("HPPREP_MIS_7"),  bit = 7,  help_text = "" },

        { menu = "divider", name = get_label_text("CELEB_ACT_3") },
        { menu = "toggle",  name = get_label_text("HPPREP_MIS_8"),  bit = 8,  help_text = "" },
        { menu = "toggle",  name = get_label_text("HPPREP_MIS_9"),  bit = 9,  help_text = "" },
        { menu = "toggle",  name = get_label_text("HPPREP_MIS_10"), bit = 10, help_text = "" },
        { menu = "toggle",  name = get_label_text("HPPREP_MIS_11"), bit = 11, help_text = "" },
        { menu = "toggle",  name = get_label_text("HPPREP_MIS_12"), bit = 12, help_text = "" },
        { menu = "toggle",  name = get_label_text("HPPREP_MIS_13"), bit = 13, help_text = "" }
    },
    DoomsdayHeistSetupListData = {
        { menu = "divider", name = Labels.ACT_1_DATA_BREACHES },
        { menu = "toggle",  name = get_label_text("HPSETUP_MIS_0"),  bit = 0,  help_text = "" },
        { menu = "toggle",  name = get_label_text("HPSETUP_MIS_1"),  bit = 1,  help_text = "" },
        { menu = "toggle",  name = get_label_text("HPSETUP_MIS_2"),  bit = 2,  help_text = "" },

        { menu = "divider", name = Labels.ACT_2_BOGDAN_PROBLEM },
        { menu = "toggle",  name = get_label_text("HPSETUP_MIS_3"),  bit = 4,  help_text = "" },
        { menu = "toggle",  name = get_label_text("HPSETUP_MIS_4"),  bit = 5,  help_text = "" },
        { menu = "toggle",  name = get_label_text("HPSETUP_MIS_5"),  bit = 6,  help_text = "" },
        { menu = "toggle",  name = get_label_text("HPSETUP_MIS_6"),  bit = 7,  help_text = "" },

        { menu = "divider", name = Labels.ACT_3_DOOMSDAY_SCENARIO },
        { menu = "toggle",  name = get_label_text("HPSETUP_MIS_7"),  bit = 9,  help_text = "" },
        { menu = "toggle",  name = get_label_text("HPSETUP_MIS_8"),  bit = 10, help_text = "" },
        { menu = "toggle",  name = get_label_text("HPSETUP_MIS_9"),  bit = 11, help_text = "" },
        { menu = "toggle",  name = get_label_text("HPSETUP_MIS_10"), bit = 12, help_text = "" },
        { menu = "toggle",  name = get_label_text("HPSETUP_MIS_11"), bit = 13, help_text = "" }
    },

    DoomsdayHeistSetupRootContent = {
        { -1984590517, get_label_text("HPSETUP_MIS_0"),  {}, "", Labels.ACT_1_DATA_BREACHES },
        { -1306877878, get_label_text("HPSETUP_MIS_1"),  {}, "", Labels.ACT_1_DATA_BREACHES },
        { 83978007,    get_label_text("HPSETUP_MIS_2"),  {}, "", Labels.ACT_1_DATA_BREACHES },

        { 1673641696,  get_label_text("HPSETUP_MIS_3"),  {}, "", Labels.ACT_2_BOGDAN_PROBLEM },
        { 1549726198,  get_label_text("HPSETUP_MIS_4"),  {}, "", Labels.ACT_2_BOGDAN_PROBLEM },
        { 1146411126,  get_label_text("HPSETUP_MIS_5"),  {}, "", Labels.ACT_2_BOGDAN_PROBLEM },
        { 1981951486,  get_label_text("HPSETUP_MIS_6"),  {}, "", Labels.ACT_2_BOGDAN_PROBLEM },

        { 1865386823,  get_label_text("HPSETUP_MIS_7"),  {}, "", Labels.ACT_3_DOOMSDAY_SCENARIO },
        { 1374735669,  get_label_text("HPSETUP_MIS_8"),  {}, "", Labels.ACT_3_DOOMSDAY_SCENARIO },
        { -1651202044, get_label_text("HPSETUP_MIS_9"),  {}, "", Labels.ACT_3_DOOMSDAY_SCENARIO },
        { 1579954143,  get_label_text("HPSETUP_MIS_10"), {}, "", Labels.ACT_3_DOOMSDAY_SCENARIO },
        { -110733685,  get_label_text("HPSETUP_MIS_11"), {}, "", Labels.ACT_3_DOOMSDAY_SCENARIO }
    },
    DoomsdayHeistFinalRootContent = {
        { 1175383697,  Labels.TheDataBreaches },    -- The Data Breaches
        { -411752237,  Labels.TheBogdanProblem },   -- The Bogdan Problem
        { -1176220645, Labels.TheDoomsdayScenario } -- The Doomsday Scenario
    },

    ------------------------
    -- Casino Heist
    ------------------------

    CasinoHeistApproach = {
        { 1, get_label_text("CHB_APPROACH_1") }, -- Silent & Sneaky
        { 2, get_label_text("CHB_APPROACH_2") }, -- The Big Con
        { 3, get_label_text("CHB_APPROACH_3") }  -- Aggressive
    },
    CasinoHeistApproach2 = {
        { 0, Labels.None },
        { 1, get_label_text("CHB_APPROACH_1") }, -- Silent & Sneaky
        { 2, get_label_text("CHB_APPROACH_2") }, -- The Big Con
        { 3, get_label_text("CHB_APPROACH_3") }  -- Aggressive
    },
    CasinoHeistTarget = {
        { 0, get_label_text("CSH_TCK_TRGCS") }, -- Cash
        { 1, get_label_text("CSH_TCK_TRGGD") }, -- Gold
        { 2, get_label_text("CSH_TCK_TRGAR") }, -- Art
        { 3, get_label_text("CSH_TCK_TRGDI") }  -- Diamonds
    },
    CasinoHeistMasks = {
        { 0,  Labels.None },
        { 1,  get_label_text("MASK_GEOMETRIC") },
        { 2,  get_label_text("MASK_HUNTERS") },
        { 3,  get_label_text("MASK_ONIHALF") },
        { 4,  get_label_text("MASK_EMOJIS") },
        { 5,  get_label_text("MASK_ORNSKULL") },
        { 6,  get_label_text("MASK_LFRUITS") },
        { 7,  get_label_text("MASK_GUERILLA") },
        { 8,  get_label_text("MASK_CLOWNS") },
        { 9,  get_label_text("MASK_ANIMAL") },
        { 10, get_label_text("MASK_RIOT") },
        { 11, get_label_text("MASK_ONIFULL") },
        { 12, get_label_text("MASK_HOCKEY") }
    },
    CasinoHeistGunman = {
        { 0, Labels.None },
        { 1, get_label_text("CH_WE_NAME_0B"), {}, "Cut: 5%" },  -- KARL_ABOLAJI
        { 3, get_label_text("CH_WE_NAME_2B"), {}, "Cut: 7%" },  -- CHARLIE
        { 5, get_label_text("CH_WE_NAME_4B"), {}, "Cut: 8%" },  -- PACKIE_MCREARY
        { 2, get_label_text("CH_WE_NAME_1B"), {}, "Cut: 9%" },  -- GUSTAVO_MOTA
        { 4, get_label_text("CH_WE_NAME_3B"), {}, "Cut: 10%" }, -- WEAPONS_EXPERT
    },
    CasinoHeistDriver = {
        { 0, Labels.None },
        { 1, get_label_text("CH_DR_NAME_0B"), {}, "Cut: 5%" },  -- KARIM_DENZ
        { 4, get_label_text("CH_DR_NAME_3B"), {}, "Cut: 6%" },  -- ZACH
        { 2, get_label_text("CH_DR_NAME_1B"), {}, "Cut: 7%" },  -- TALIANA_MARTINEZ
        { 3, get_label_text("CH_DR_NAME_2B"), {}, "Cut: 9%" },  -- EDDIE_TOH
        { 5, get_label_text("CH_DR_NAME_4B"), {}, "Cut: 10%" }, -- WEAPONS_EXPERT
    },
    CasinoHeistHacker = {
        { 0, Labels.None },
        { 1, get_label_text("CH_HR_NAME_0B"), {}, "Cut: 3%" },  -- RICKIE_LUKENS
        { 3, get_label_text("CH_HR_NAME_2B"), {}, "Cut: 5%" },  -- YOHAN
        { 2, get_label_text("CH_HR_NAME_1B"), {}, "Cut: 7%" },  -- CHRISTIAN_FELTZ
        { 5, get_label_text("CH_HR_NAME_4B"), {}, "Cut: 9%" },  -- PAIGE_HARRIS
        { 4, get_label_text("CH_HR_NAME_3B"), {}, "Cut: 10%" }, -- AVI_SCHWARTZMAN
    },

    CasinoHeistFinalRootContent = {
        [1] = -954000712, -- ciCASINO_HEIST_MISSION_STEALTH_STAGE_5A
        [2] = 1069383608, -- ciCASINO_HEIST_MISSION_SUBTERFUGE_STAGE_5A
        [3] = -1313224488 -- ciCASINO_HEIST_MISSION_DIRECT_STAGE_5A
    },

    CasinoHeistMandatoryPrepListData = {
        { menu = "divider", name = get_label_text("CHB_MISSIONS") },
        { menu = "toggle",  name = get_label_text("CH_TODO_SETUP_1"),  bit = 0, help_text = "" },
        { menu = "toggle",  name = get_label_text("CH_TODO_PREP_3"),   bit = 1, help_text = "" },
        { menu = "toggle",  name = get_label_text("CH_TODO_PREP_0"),   bit = 2, help_text = "" },
        { menu = "toggle",  name = get_label_text("CH_TODO_PREP_1"),   bit = 3, help_text = "" },
        { menu = "toggle",  name = get_label_text("CH_TODO_PREP_2"),   bit = 4, help_text = "" },

        { menu = "divider", name = get_label_text("CHB_APPROACH_SPEC") },
        { menu = "toggle",  name = get_label_text("CH_TODO_PREP_4"),   bit = 5, help_text = "" },
        { menu = "toggle",  name = get_label_text("CH_TODO_PREP_5"),   bit = 6, help_text = "" },
        { menu = "toggle",  name = get_label_text("CH_TODO_PREP_9"),   bit = 7, help_text = "" },
        { menu = "toggle",  name = get_label_text("CH_TODO_PREP_7"),   bit = 8, help_text = "" },
        { menu = "toggle",  name = get_label_text("CH_TODO_PREP_6"),   bit = 9, help_text = "" }
    },
    CasinoHeistOptionalPrepListData = {
        { menu = "divider", name = get_label_text("CHB_MISSIONS") },
        { menu = "toggle",  name = get_label_text("CH_OPT_PREP_2"),             bit = 0,  help_text = "" },
        { menu = "toggle",  name = get_label_text("CH_OPT_PREP_0"),             bit = 1,  help_text = "" },
        { menu = "toggle",  name = get_label_text("CH_OPT_PREP_1"),             bit = 2,  help_text = "" },
        { menu = "toggle",  name = get_label_text("CH_OPT_PREP_3"),             bit = 4,  help_text = "" },
        { menu = "toggle",  name = get_label_text("CH_OPT_FIN_0"),              bit = 6,  help_text = "" },
        { menu = "toggle",  name = get_label_text("CH_OPT_FIN_1"),              bit = 7,  help_text = "" },

        { menu = "divider", name = get_label_text("CHB_APPROACH_SPEC") },
        { menu = "toggle",  name = get_label_text("CH_OPT_PREP_7"),             bit = 3,  help_text = "" },
        { menu = "toggle",  name = get_label_text("CH_OPT_PREP_6"),             bit = 5,  help_text = "" },
        { menu = "toggle",  name = get_label_text("CSG_ITEM_BUGEQS"),           bit = 8,  help_text = "" },
        { menu = "toggle",  name = get_label_text("CSG_ITEM_TMS"),              bit = 9,  help_text = "" },
        { menu = "toggle",  name = get_label_text("CSG_ITEM_MTOS"),             bit = 10, help_text = "" },
        { menu = "toggle",  name = get_label_text("CSG_ITEM_MTOS2"),            bit = 11, help_text = "" },
        { menu = "toggle",  name = get_label_text("CSG_ITEM_GSOSA"),            bit = 12, help_text = "" },
        { menu = "toggle",  name = get_label_text("CSG_ITEM_GSOSB"),            bit = 13, help_text = "" },
        { menu = "toggle",  name = get_label_text("CELL_CELEB_N") .. " 1",      bit = 14, help_text = "" },
        { menu = "toggle",  name = get_label_text("CELL_CELEB_N") .. " 2",      bit = 15, help_text = "" },
        { menu = "toggle",  name = get_label_text("CSH_ITEM_NOOSES"),           bit = 16, help_text = "" },
        { menu = "toggle",  name = get_label_text("CSG_ITEM_FFOS"),             bit = 17, help_text = "" },
        { menu = "toggle",  name = get_label_text("MC_O_HIGHROLL"),             bit = 18, help_text = "" },
        { menu = "toggle",  name = get_label_text("CH_OPT_PREP_10"),            bit = 19, help_text = "" },
        { menu = "toggle",  name = get_label_text("CH_OPT_PREP_9"),             bit = 20, help_text = "" },
        { menu = "toggle",  name = get_label_text("CH_TODO_PREP_6b") .. " (?)", bit = 21, help_text = "" }
    },

    ------------------------
    -- Island Heist
    ------------------------

    IslandHeistMainTarget = {
        { 0, get_label_text("H4_LOOT_TEQ") },   -- SINSIMITO TEQUILA
        { 1, get_label_text("H4_LOOT_NKLC") },  -- RUBY NECKLACE
        { 2, get_label_text("H4_LOOT_BONDS") }, -- BEARER BONDS
        { 3, get_label_text("H4_LOOT_DIAM") },  -- PINK DIAMOND
        { 4, get_label_text("H4_LOOT_FILES") }, -- MADRAZO FILES
        { 5, get_label_text("H4_LOOT_STAT") }   -- PANTHER STATUE
    },
    IslandHeistAdditionalLoot = {
        { 0, Labels.NONE },
        { 1, get_label_text("H4P_INT2_CASH_T") }, -- CASH
        { 2, get_label_text("H4P_INT2_WEED_T") }, -- WEED
        { 3, get_label_text("H4P_INT2_COKE_T") }, -- COCAINE
        { 4, get_label_text("H4P_INT2_GOLD_T") }, -- GOLD
        -- { 5, get_label_text("H4P_INT2_PAIN_T") }, -- PAINTINGS
    },

    ------------------------
    -- Farm Raid
    ------------------------

    FarmRaidPrepListData = {
        { bit = 0, name = get_label_text("SALV23_CFR_1"), help_text = "" }, -- Slush Fund
        { bit = 1, name = get_label_text("SALV23_CFR_2"), help_text = "" }, -- Setup: Breaking and Entering
        { bit = 2, name = get_label_text("SALV23_CFR_3"), help_text = "" }, -- Setup: Concealed Weapons
        { bit = 3, name = get_label_text("SALV23_CFR_4"), help_text = "" }, -- Setup: Hit and Run
        { bit = 4, name = get_label_text("SALV23_CFR_5"), help_text = "" }, -- Setup: Disorganized Crime
    },


    ------------------------------------
    --    MISC
    ------------------------------------

    EliteChallenge = {
        { 0, Labels.Default },
        { 1, "完成" },
        { 2, "未完成" }
    },

    BooleanSelect = {
        { -1, Labels.Default },
        { 1,  Labels.Yes },
        { 0,  Labels.No }
    },

    CompleteReset = {
        Labels.Complete,
        Labels.Reset
    },
}




PackedStats = {
    PACKED_MP_INT_HANGAR_PRODUCT_0 = 16011, -- ~ PACKED_MP_INT_HANGAR_PRODUCT_49 = 16060
}
