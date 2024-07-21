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
}

Labels.SpecialCargoWarehouse = string.format("%s %s", Labels.SpecialCargo, Labels.Warehouse)
Labels.LaunchMissionByTerrorbyte = string.format("%s (%s %s)", Labels.LaunchMission, Labels.Terrorbyte, Labels.Computer)
Labels.LaunchMissionByBunker = string.format("%s (%s %s)", Labels.LaunchMission, Labels.Bunker, Labels.Computer)
Labels.LaunchMissionByHangar = string.format("%s (%s %s)", Labels.LaunchMission, Labels.Hangar, Labels.Computer)




Lang = {
    O_W_F_INS_FIN = "仅在直接完成任务生效",
    E_B_S_M = "确保在任务开启前启用",

    SelectMission = "选择任务",
    CashReward = "收入奖励",
    MissionReward = "任务奖励",
    SetMissionReward = "设置任务奖励",
}




Tables = {
    ------------------------
    -- Business Mission
    ------------------------

    ContrabandBuy = {
        { -1, Labels.RANDOM,              {}, "" },
        { 0,  "Vehicle Collection",       {}, "" },
        { 1,  "Moved Collection",         {}, "" },
        { 2,  "Cargo Drop",               {}, "" },
        { 3,  "Moving Vehicle",           {}, "" },
        { 4,  "Break Up Deal",            {}, "" },
        { 5,  "Ambushed",                 {}, "" },
        { 6,  "Steal Riot Van",           {}, "" },
        { 7,  "Gang Hideout",             {}, "" },
        { 8,  "Heli Takedown",            {}, "" },
        { 9,  "Valkyrie Takedown",        {}, "" },
        { 10, "Crash Site",               {}, "" },
        { 11, "Thief",                    {}, "" },
        { 12, "Trapped",                  {}, "" },
        { 13, "Aftermath",                {}, "" },
        { 14, "Trackify",                 {}, "" },
        { 15, "Assassination",            {}, "" },
        { 16, "Boat Attack",              {}, "" },
        { 17, "Multiple Moving Vehicles", {}, "" },
    },
    ContrabandSell = {
        { -1, Labels.RANDOM,    {}, "" },
        { 0,  "Default",        {}, "Single drop-off. Simple collect and deliver." },
        { 1,  "Multiple",       {}, "5 drop-offs across city. Paid per location (20%)." },
        { 2,  "Sting",          {}, "5 drop-offs across city. Paid per location (20%). One location will randomly trigger a 3 star Wanted Rating when the contraband is dropped off." },
        { 3,  "Land Damage",    {}, "Buyer wants the vehicle in mint condistion.$10,000 bonus appears on screen but every small knocks damages the contraband and lowers its value slightly (player must drive carefully)." },
        { 4,  "Land Trackify",  {}, "Single Drop Off. Player receives text from PA saying buyer is overly cautious. Use trackify to find the drop off location." },
        { 5,  "Land Attack",    {}, "" },
        { 6,  "Land Defend",    {}, "Contraband vehicle gets attacked after vehicle is dropped off.	" },
        { 7,  "Air Low",        {}, "Drive to LSIA to collect a plane then make 5 drops across the map. Fly low to avoid detection from the cops. If you go to high you gain 3 stars and must lost the cops to continue." },
        { 8,  "Air Drop",       {}, "Drive to LSIA to collect a plane then make 5 drops across the map." },
        { 9,  "Air Clear Area", {}, "Drive to LSIA to collect a plane then take plane to the country side drop off, kill enemies at drop off." },
        { 10, "Air Restricted", {}, "Drive to LSIA to collect a plane, make the four drop off, last is in a restricted area, lose the cops to complete the mission." },
        { 11, "Air Attack",     {}, "Drive to LSIA to collect a plane then make 5 drops across the map, get attacked by AI choppers." },
        { 12, "Sea Attack",     {}, "Go to the docks and collect a speeder to meet a contact out at sea. Attacked on route by AI gang peds in boats and helicopter." },
        { 13, "Sea Defend",     {}, "Go to the docks and kill enemies that are surrounding your Speeder before you get in it to meet a contact out at sea." },
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
        { 0,  "Beacon Grab",    {}, "" },
        { 1,  "Black Box",      {}, "" },
        { 2,  "Bomb Base",      {}, "" },
        { 3,  "Bombing Run",    {}, "" },
        { 4,  "Cargo Plane",    {}, "" },
        { 5,  "Bomb Roof",      {}, "" },
        { 6,  "Crate Chase",    {}, "" },
        { 7,  "Dogfight",       {}, "" },
        { 8,  "Escort",         {}, "" },
        { 9,  "Infiltration",   {}, "" },
        { 10, "Roof Attack",    {}, "" },
        { 11, "Splash Landing", {}, "" },
        { 12, "Steal Aircraft", {}, "" },
        { 13, "Stunt Pilot",    {}, "" },
        { 14, "Thermal Scope",  {}, "" },
    },
    SmugglerSell = {
        { -1, Labels.RANDOM,        {}, "" },
        { 15, "Agile Delivery",     {}, "" },
        { 16, "Air Delivery",       {}, "" },
        { 17, "Air Police",         {}, "" },
        { 18, "Air Transfer",       {}, "" },
        { 19, "Bombardment",        {}, "" },
        { 20, "Contested",          {}, "" },
        { 21, "Flying Fortress",    {}, "" },
        { 22, "Fly Low",            {}, "" },
        { 23, "Heavy Lifting",      {}, "" },
        { 24, "Precision Delivery", {}, "" },
        { 25, "Under The Radar",    {}, "" },
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
        { 1,  "Altruists",       {}, "" },
        { 2,  "Destroy Trucks",  {}, "" },
        { 3,  "Diversion",       {}, "" },
        { 4,  "Flashlight",      {}, "" },
        { 5,  "Fly Swatter",     {}, "" },
        { 6,  "Rival Operation", {}, "" },
        { 7,  "Steal Apc",       {}, "" },
        { 8,  "Steal Miniguns",  {}, "" },
        { 9,  "Steal Railguns",  {}, "" },
        { 10, "Steal Rhino",     {}, "" },
        { 11, "Steal Technical", {}, "" },
        { 12, "Steal Van",       {}, "" },
        { 13, "Yacht Search",    {}, "" },
    },
    GunrunSell = {
        { -1, Labels.RANDOM,       {}, "" },
        { 14, "Ambushed",          {}, "" },
        { 15, "Follow The Leader", {}, "" },
        { 16, "Hill Climb",        {}, "" },
        { 17, "Move Weapons",      {}, "" },
        { 18, "Phantom",           {}, "" },
        { 19, "Rough Terrain",     {}, "" },
    },

    AcidLabSource = {
        { -1, Labels.RANDOM,        {}, "" },
        { 0,  "Chemical Spill",     {}, "" },
        { 1,  "Volatile Chemicals", {}, "" },
        { 2,  "Stealing Grain",     {}, "" },
        { 3,  "Missing Air Drop",   {}, "" },
        { 4,  "Deludomal Vans",     {}, "" },
    },
    AcidLabSell = {
        { -1, Labels.RANDOM,    {}, "" },
        { 0,  "Paperboy",       {}, "" },
        { 1,  "Police Sting",   {}, "" },
        { 2,  "Stash Delivery", {}, "" },
    },

    NightclubSell = {
        { -1, Labels.RANDOM,       {}, "" },
        { 6,  "Single Drop",       {}, "" },
        { 7,  "Multi Drop",        {}, "" },
        { 8,  "Hack Drop",         {}, "" },
        { 9,  "Roadblock",         {}, "" },
        { 10, "Protect Buyer",     {}, "" },
        { 11, "Undercover Cops",   {}, "" },
        { 12, "Offshore Transfer", {}, "" },
        { 13, "Not a Scratch",     {}, "" },
        { 14, "Follow Heli",       {}, "" },
        { 15, "Find Buyer",        {}, "" },
    },

    BikerResupply = {
        { -1, Labels.RANDOM,              {}, "", "" },

        { 0,  "Weed Farm",                {}, "", "Variations" },
        { 1,  "Fragile Supplies",         {}, "", "Variations" },
        { 2,  "Drug Lab",                 {}, "", "Variations" },
        { 3,  "Chemicals",                {}, "", "Variations" },
        { 4,  "Kill Dealers",             {}, "", "Variations" },
        { 5,  "Meet Contact",             {}, "", "Variations" },
        { 6,  "Destroy Crates",           {}, "", "Variations" },
        { 7,  "Security Vans",            {}, "", "Variations" },
        { 8,  "Repairman",                {}, "", "Variations" },
        { 9,  "Lure",                     {}, "", "Variations" },
        { 10, "Bank",                     {}, "", "Variations" },
        { 11, "Intimidation",             {}, "", "Variations" },
        { 12, "Biker Melee",              {}, "", "Variations" },
        { 13, "Brawl",                    {}, "", "Variations" },
        { 14, "Signal Flare",             {}, "", "Variations" },

        { 15, "Weed Setup",               {}, "", "Setups" },
        { 16, "Meth Setup",               {}, "", "Setups" },
        { 17, "Coke Setup",               {}, "", "Setups" },
        { 18, "Fake ID Setup",            {}, "", "Setups" },
        { 19, "Counterfeit Setup",        {}, "", "Setups" },

        { 20, "Vehicle Collection",       {}, "", "Global Backup" },

        { 21, "Moving Vehicle",           {}, "", "Legacy" },
        { 22, "Moved Collection",         {}, "", "Legacy" },
        { 23, "Cargo Drop",               {}, "", "Legacy" },
        { 24, "Break Up Deal",            {}, "", "Legacy" },
        { 25, "Ambushed",                 {}, "", "Legacy" },
        { 26, "Impounded",                {}, "", "Legacy" },
        { 27, "Steal Riot Van",           {}, "", "Legacy" },
        { 28, "Police Sting",             {}, "", "Legacy" },
        { 29, "Gang Hideout",             {}, "", "Legacy" },
        { 30, "Heli Takedown",            {}, "", "Legacy" },
        { 31, "Valkyrie Takedown",        {}, "", "Legacy" },
        { 32, "Crash Site",               {}, "", "Legacy" },
        { 33, "Thief",                    {}, "", "Legacy" },
        { 34, "Trapped",                  {}, "", "Legacy" },
        { 35, "Aftermath",                {}, "", "Legacy" },
        { 36, "Trackify",                 {}, "", "Legacy" },
        { 37, "Assassination",            {}, "", "Legacy" },
        { 38, "Boat Attack",              {}, "", "Legacy" },
        { 39, "Multiple Moving Vehicles", {}, "", "Legacy" },
    },
    BikerSell = {
        { -1, Labels.RANDOM,     {}, "" },
        { 0,  "Default",         {}, "" },
        { 1,  "Air Drop At Sea", {}, "" },
        { 2,  "Helicopter Drop", {}, "" },
        { 3,  "Trashmaster",     {}, "" },
        { 4,  "Friends In Need", {}, "" },
        { 5,  "Postman",         {}, "" },
        { 6,  "Sting Op",        {}, "" },
        { 7,  "Proven",          {}, "" },
        { 8,  "Benson",          {}, "" },
        { 9,  "Border Patrol",   {}, "" },
        { 10, "Bag Drop",        {}, "" },
        { 11, "Race",            {}, "" },
        { 12, "Club Run",        {}, "" },
    },

    VehicleExportSteal = {
        { -1, Labels.RANDOM,              {}, "" },
        { 0,  "Vehicle Collection",       {}, "" },
        { 1,  "Moving Vehicle",           {}, "" },
        { 2,  "Cargobob",                 {}, "" },
        { 3,  "Drunk Driver",             {}, "" },
        { 4,  "Photo Shoot",              {}, "" },
        { 5,  "Picture Message",          {}, "" },
        { 6,  "Crime Scene",              {}, "" },
        { 7,  "Protected Vehicle",        {}, "" },
        { 8,  "Sell",                     {}, "" },
        { 9,  "Party Crasher",            {}, "" },
        { 10, "Car Meet",                 {}, "" },
        { 11, "Police Chase",             {}, "" },
        { 12, "Eye In The Sky",           {}, "" },
        { 13, "Bomb Defuse",              {}, "" },
        { 14, "Lapped Race",              {}, "" },
        { 15, "Stunt Man",                {}, "" },
        { 16, "Race Driver",              {}, "" },
        { 17, "Tail Vehicle",             {}, "" },

        { 18, "Moved Collection",         {}, "", "Old" },
        { 19, "Cargo Drop",               {}, "", "Old" },
        { 20, "Break Up Deal",            {}, "", "Old" },
        { 21, "Ambushed",                 {}, "", "Old" },
        { 22, "Impounded",                {}, "", "Old" },
        { 23, "Steal Riot Van",           {}, "", "Old" },
        { 24, "Police Sting",             {}, "", "Old" },
        { 25, "Gang Hideout",             {}, "", "Old" },
        { 26, "Heli Takedown",            {}, "", "Old" },
        { 27, "Valkyrie Takedown",        {}, "", "Old" },
        { 28, "Crash Site",               {}, "", "Old" },
        { 29, "Thief",                    {}, "", "Old" },
        { 30, "Trapped",                  {}, "", "Old" },
        { 30, "Aftermath",                {}, "", "Old" },
        { 30, "Trackify",                 {}, "", "Old" },
        { 30, "Assassination",            {}, "", "Old" },
        { 30, "Boat Attack",              {}, "", "Old" },
        { 30, "Multiple Moving Vehicles", {}, "", "Old" },
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

    ------------------------
    -- Business
    ------------------------

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

    ------------------------
    -- Freemode Mission
    ------------------------

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
        { 0,  "Tugboat" },
        { 1,  "Truck" },
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

    ------------------------
    -- Freemode Preps
    ------------------------

    TunerRobbery = {
        { -1, Labels.RANDOM },
        { 0,  get_label_text("TR_STSTART_STP"), {}, "", get_label_text("TR_STSTART_T2") }, -- TRV_SETUP
        { 1,  get_label_text("TR_STSTART_EP"),  {}, "", get_label_text("TUNPLAN_ROB0") },  -- TRV_ELEVATOR_PASS
        { 2,  get_label_text("TR_STSTART_VK"),  {}, "", get_label_text("TUNPLAN_ROB0") },  -- TRV_VAULT_KEY_CODES
        { 3,  get_label_text("TR_STSTART_ST"),  {}, "", get_label_text("TUNPLAN_ROB1") },  -- TRV_SCOPE_TRANSPORTER
        { 4,  get_label_text("TR_STSTART_CV"),  {}, "", get_label_text("TUNPLAN_ROB1") },  -- TRV_COMPUTER_VIRUS
        { 5,  get_label_text("TR_STSTART_TC"),  {}, "", get_label_text("TUNPLAN_ROB2") },  -- TRV_THERMAL_CHARGES
        { 6,  get_label_text("TR_STSTART_SJ"),  {}, "", get_label_text("TUNPLAN_ROB2") },  -- TRV_SIGNAL_JAMMERS
        { 7,  get_label_text("TR_STSTART_CM"),  {}, "", get_label_text("TUNPLAN_ROB3") },  -- TRV_CONTAINER_MANIFEST
        { 8,  get_label_text("TR_STSTART_TS"),  {}, "", get_label_text("TUNPLAN_ROB3") },  -- TRV_TRAIN_SCHEDULE
        { 9,  get_label_text("TR_STSTART_IM"),  {}, "", get_label_text("TUNPLAN_ROB4") },  -- TRV_INSIDE_MAN
        { 10, get_label_text("TR_STSTART_SR"),  {}, "", get_label_text("TUNPLAN_ROB4") },  -- TRV_STUNT_RAMP
        { 11, get_label_text("TR_STSTART_IA"),  {}, "", get_label_text("TUNPLAN_ROB5") },  -- TRV_IAA_PASS
        { 12, get_label_text("TR_STSTART_SS"),  {}, "", get_label_text("TUNPLAN_ROB5") },  -- TRV_SEWER_SCHEMATICS
        { 13, get_label_text("TR_STSTART_ML"),  {}, "", get_label_text("TUNPLAN_ROB6") },  -- TRV_METH_LAB_LOCATIONS
        { 14, get_label_text("TR_STSTART_MT"),  {}, "", get_label_text("TUNPLAN_ROB6") },  -- TRV_METH_TANKER
        { 15, get_label_text("TR_STSTART_LB"),  {}, "", get_label_text("TUNPLAN_ROB7") },  -- TRV_LOCATE_BUNKER
        { 16, get_label_text("TR_STSTART_WD"),  {}, "", get_label_text("TUNPLAN_ROB7") },  -- TRV_WAREHOUSE_DEFENCES
    },
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

    ------------------------
    -- Heists
    ------------------------

    ---- Auto Shop Robbery
    TunerRobberyFinalRootContent = {
        { 2064133602,  get_label_text("TUNPLAN_ROB0") }, -- TR_UNION_DEPOSITORY
        { 1364299584,  get_label_text("TUNPLAN_ROB1") }, -- TR_MILITARY_CONVOY
        { 14434931,    get_label_text("TUNPLAN_ROB2") }, -- TR_FLEECA_BANK
        { 808119513,   get_label_text("TUNPLAN_ROB3") }, -- TR_FREIGHT_TRAIN
        { -554734818,  get_label_text("TUNPLAN_ROB4") }, -- TR_BOLINGBROKE
        { -1750247281, get_label_text("TUNPLAN_ROB5") }, -- TR_IAA_RAID
        { 1767266297,  get_label_text("TUNPLAN_ROB6") }, -- TR_METH_JOB
        { -1931849607, get_label_text("TUNPLAN_ROB7") }  -- TR_BUNKER
    },

    ---- Apartment Heist
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

    ---- Doomsday Heist
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

    ---- Casino Heist
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

    ---- Island Heist
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
    -- Misc
    ------------------------

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
