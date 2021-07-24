-- This script create for Las Venturas Army Evolve Role Play 02
-- Script author Nicho. Contacts - https://vk.com/n1chooff
-- version 0.8

script_name("LVa Helper")
script_version('0.8')

local sname = '{51964D}[LVa Helper]:{ffffff} '
-------- trash -------
local CarsName = {"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
"Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BFInjection", "Hunter",
"Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo",
"RCBandit", "Romero","Packer", "Monster", "Admiral", "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed",
"Yankee", "Caddy", "Solair", "Berkley'sRCVan", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RCBaron", "RCRaider", "Glendale", "Oceanic", "Sanchez", "Sparrow",
"Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage",
"Dozer", "Maverick", "NewsChopper", "Rancher", "FBIRancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "BlistaCompact", "PoliceMaverick",
"Boxvillde", "Benson", "Mesa", "RCGoblin", "HotringRacerA", "HotringRacerB", "BloodringBanger", "Rancher", "SuperGT", "Elegant", "Journey", "Bike",
"MountainBike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "hydra", "FCR-900", "NRG-500", "HPV1000",
"CementTruck", "TowTruck", "Fortune", "Cadrona", "FBITruck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight",
"Streak", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada",
"Yosemite", "Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RCTiger", "Flash", "Tahoma", "Savanna", "Bandito",
"FreightFlat", "StreakCarriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400", "NewsVan",
"Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club", "FreightBox", "Trailer", "Andromada", "Dodo", "RCCam", "Launch", "PoliceCar", "PoliceCar",
"PoliceCar", "PoliceRanger", "Picador", "S.W.A.T", "Alpha", "Phoenix", "GlendaleShit", "SadlerShit", "Luggage A", "Luggage B", "Stairs", "Boxville", "Tiller",
"UtilityTrailer"}

local DopBind = {'{MyId} - ваш ID','{MyName} - ваш ник с "_"','{MyNameR} - ваш ник без "_"','{TarName} - ник цели(Target)','{TarNameR} - ник цели(Target) без "_"','{TarID} - ID цели(Target)',
    '{CarName} - название машины','{CarHealt} - состояние машины','{PassegerName} - Ник(-и) пасажиров без "_"',"{PassegerID} - ID(-ы) ваших пасажиров",
    '{KV} - пишет ваш квадрат','{MyTeg} - ваш тег в рацию','{MyRang} - ваш ранг','{NowDate} - возвращает время в формате H:M:S'}
local DopText = ""

for _, str in ipairs(DopBind) do
    DopText = DopText .. str .. "\n"
end


dayName = {"Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"}
dayNameS = {'Mon','Tue','Wed','Thu','Fri','Sat','Sun'}
----------------------
-- import ------
require 'lib.moonloader'
local sampev = require 'lib.samp.events'
local imgui = require "imgui"
local inicfg = require "inicfg"
local key = require "vkeys"
local imadd = require 'imgui_addons'
local weapons = require 'game.weapons'
local memory = require "memory"
local dlstatus = require('moonloader').download_status
local pie = nil
-----------------

------- locals
local complete = false
local mouseCord = false
local mouseCordPost = false
local fastmenu = false
local restart = false
local imwin = nil -- для меню настроек
local autoBP = 1
local line_binder = 50
local changeBind = nil
local levelBinder = {}
local pric = ''
local modBinder = {}
local tid = nil
local startTime = nil
local afkTime = 0
local afkTimeS = 0
local sesionOnline = 0
local sesionOnline1 = 0
local FastMenuMasive = {}
local monikQuant = {}
local departamentlog = {}
local smslog = {}
local patrul = false
local timePatrule = 0
local afkPatrule = 0
local timesDoklad = 0
local checkPass = 0
local sessionDoklad = 0
local sessionPass = 0
local testLocal = 0
local MaskOn=false
----- hot key ------
local rkeys = require 'rkeys'
imgui.HotKey = require('imgui_addons').HotKey

local tLastKeys = {}

------ settings -------


local newIni = {
    config = {
        rteg = '',
        acls = '7',
        infbr = false,
        modRacia=false,
        modMembers=false,
        rangName = nil,
        sex = 0,
        fraction = nil
    },
    settings = {
        autoTeg = false,
        autoClist = false,
        autoBP = false,
        chatT = false,
        style=0,
        metka=false
    },
    abp = {
        deagle = false,
        shot = false,
		smg = false,
		m4 = false,
		rifle = false,
		armour = false,
		spec = false,
        close = false
    }
}
local newInf = {
    sett = {
        ShowTitle = true,
        ShowNick = true,
        ShowStut = true,
        ShowTarget = true,
        ShowGuns = true,
        ShowCar = true,
        ShowCord = true,
        ShowDate = true,
        ShowOnline = true,
        invisiable = 0.7,
        rounding = 0,
        height = 180,
        weight = 280,
        x = 600,
        y = 500
    }
}
local newBind = {
    a = {
        [1] = ''
    },
    f1 = {
        name = 'Действия',
        names1 = 'Связать',
        ['1x1'] = '/me заломал руки человеку напротив, затем достал веревку и связал человека',
        ['2x1'] = '/tie {TarID}',
        names2 = 'Развязать',
        ['1x2'] = '/do На ноге пристегнута кобура для ножа',
        ['2x2'] = '/me достал из кобуры нож, затем резким движением разрезал верёвку',
        ['3x2'] = '/untie {TarID}',
        wait2 = 1000,
        wait1 = 1000
    },
    f2 = {
        name = 'Показать',
        names1 = 'Паспорт',
        ['1x1'] = '/showpass {TarID}',
        names2 = 'Лицензии',
        ['1x2'] = '/showlicenses {TarID}'
    },
    f3 = {
        name = 'Запросить',
        names1 = 'Местоположение',
        ['1x1'] = '/r {MyTag} {TarName} ваше местонахождение. На ответ 30 секунд',
        names2 = 'Документы',
        ['1x2'] = 'Здравия желаю, я {MyRang} {MyNameR}.Предъявите ваши документы'
    },
    fset = {
        style = 0,
        act = '[90]'
    }
}
local newOnl = {
    day = {
        MonOnl = 0,
        MonAFK = 0,
        TueOnl = 0,
        TueAFK = 0,
        WedOnl = 0,
        WedAFK = 0,
        ThuOnl = 0,
        ThuAFK = 0,
        FriOnl = 0,
        FriAFK = 0,
        SatOnl = 0,
        SatAFK = 0,
        SunOnl = 0,
        SunAFK = 0
    },
    week = {
        onl = 0,
        afk = 0,
        weak = os.date('%W')
    }
}

local newPost = {
    [1] = {
        posy2=1953.1899414063,
        posx1=145.50761413574,
        posx2=121.62959289551,
        posy1=1923.1955566406,
        name='КПП-1'
    },
    [2] = {
        posy2=1780.8250732422,
        posx1=321.31732177734,
        posx2=378.43142700195,
        posy1=1807.7802734375,
        name='КПП-2'
    },
    [3] = {
        posy2=1976.8321533203,
        posx1=320.78259277344,
        posx2=389.52847290039,
        posy1=1890.4631347656,
        name='ГС'
    },
    [4] = {
        posy2=1927.048828125,
        posx1=102.26336669922,
        posx2=90.826507568359,
        posy1=1914.8802490234,
        name='ЧВ'
    },
    [5] = {
        posy2=-2384.1728515625,
        posx1=2733.5170898438,
        posx2=2705.6879882813,
        posy1=-2417.642578125,
        name='СКПП'
    },
    [6] = {
        posy2=-2513.6733398438,
        posx1=2733.5280761719,
        posx2=2708.2966308594,
        posy1=-2487.2551269531,
        name='ЮКПП'
    },
    stat = {
        weakDoklad=0,
        weakPass=0,
        weak=os.date('%W')
    },
    sett = {
        y=620,
        x=725,
        invisiable=0.5,
        rounding=5
    }
}
function sampev.onSendClientJoin(version, mod, nick)
    
end

---------- imgui -------------
local encoding = require 'encoding' 
encoding.default = 'CP1251' 
u8 = encoding.UTF8

local mws = imgui.ImBool(false) -- main window state
local sws = imgui.ImBool(false) -- settings window state
local bws = imgui.ImBool(false) -- binder window state
local dws = imgui.ImBool(false) -- dop window state
local ows = imgui.ImBool(false) -- online window state
local fws = imgui.ImBool(false) -- fast-menu redact window state
local pws = imgui.ImBool(false) -- post window state
local aws = imgui.ImBool(false) -- about script window state
local uws = imgui.ImBool(false) -- update window state


local FastMenuEdit1 = imgui.ImInt(0)

local success = imgui.ImBool(false)
--------------
local sw,sh = getScreenResolution()



function imgui.OnDrawFrame()
    infbr = imgui.ImBool(mainIni.config.infbr) 

    if not mws.v and not sws.v and not infbr.v and not bws.v and not fastmenu and not dws.v and not ows.v and not fws.v and not pws.v and not patrul and not aws.v and not uws.v then
        imgui.Process = false
    end

    
    local _,MyId = sampGetPlayerIdByCharHandle(PLAYER_PED)
    local MyName = sampGetPlayerNickname(MyId)
    local MyColor = string.format("%06X", ARGBtoRGB(sampGetPlayerColor(MyId)))
    local MyHealth = getCharHealth(PLAYER_PED)
    local MyArmor = sampGetPlayerArmor(MyId)
    local IDweapon = getCurrentCharWeapon(PLAYER_PED)
    -- vehicle --
    local CarHandle = getCarCharIsUsing(PLAYER_PED)
    -- target ---
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    -------------

    dcf = getWorkingDirectory()..'\\cfg\\'..MyName..'\\config.ini'
    mainIni = inicfg.load(nil,dcf)

    dci = getWorkingDirectory()..'\\cfg\\'..MyName..'\\infbar.ini'
    infIni = inicfg.load(nil,dci)

    dcb = getWorkingDirectory()..'\\cfg\\'..MyName..'\\binder.ini'
    binderIni = inicfg.load(nil,dcb)


    ------- infobar --------
    local ISX = infIni.sett.x
    local ISY = infIni.sett.y

    local infHeight = imgui.ImInt(infIni.sett.height)
    local infWeight = imgui.ImInt(infIni.sett.weight)

    local levelInvisiable = imgui.ImFloat(infIni.sett.invisiable)
    local levelRounding = imgui.ImInt(infIni.sett.rounding)
    -------------------------
    ---- auto-bp ---------
    local useAutoBP = imgui.ImBool(mainIni.settings.autoBP)

    local abpDeagle = imgui.ImBool(mainIni.abp.deagle)
    local abpShot = imgui.ImBool(mainIni.abp.shot)
    local abpSMG = imgui.ImBool(mainIni.abp.smg)
    local abpM4 = imgui.ImBool(mainIni.abp.m4)
    local abpRifle = imgui.ImBool(mainIni.abp.rifle)
    local abpArmour = imgui.ImBool(mainIni.abp.armour)
    local abpSpec = imgui.ImBool(mainIni.abp.spec)
    local abpClose = imgui.ImBool(mainIni.abp.close)
    ----------------------
    --- buffer ---
    local inputRteg = imgui.ImBuffer(tostring(u8(mainIni.config.rteg)),32)
    local inputPrichina = imgui.ImBuffer(u8(pric),256)
    ------ check box -----
    
    local useAutoTeg = imgui.ImBool(mainIni.settings.autoTeg)
    local useChatT = imgui.ImBool(mainIni.settings.chatT)
    local useAutoClist = imgui.ImBool(mainIni.settings.autoClist)
    local useModRacia = imgui.ImBool(mainIni.config.modRacia)
    local useModMembers = imgui.ImBool(mainIni.config.modMembers)
    local useInfBr = imgui.ImBool(mainIni.config.infbr)
    local useMetka = imgui.ImBool(mainIni.settings.metka)

    local numClist = imgui.ImInt(mainIni.config.acls)
    local fastStyle = imgui.ImInt(binderIni.fset.style)
    local StyleScript = imgui.ImInt(mainIni.settings.style)
    -------- check box infobar------
    local useShowTitle = imgui.ImBool(infIni.sett.ShowTitle)
    local useShowNick = imgui.ImBool(infIni.sett.ShowNick)
    local useShowStut = imgui.ImBool(infIni.sett.ShowStut)
    local useShowTarget = imgui.ImBool(infIni.sett.ShowTarget)
    local useShowGuns = imgui.ImBool(infIni.sett.ShowGuns)
    local useShowCar = imgui.ImBool(infIni.sett.ShowCar)
    local useShowCord = imgui.ImBool(infIni.sett.ShowCord)
    local useShowDate = imgui.ImBool(infIni.sett.ShowDate)
    local useShowOnline = imgui.ImBool(infIni.sett.ShowOnline)
    --------------------------------
    local btn_size = imgui.ImVec2(-0.1, 0)


    ------ post -----
    local levelInvisiablePost = imgui.ImFloat(postIni.sett.invisiable)
    local levelRoundingPost = imgui.ImInt(postIni.sett.rounding)

    if mws.v then
        
        imgui.ShowCursor = true

        imgui.SetNextWindowSize(imgui.ImVec2(300, 200), imgui.Cond.FirstUseEver) -- resoluthion window
        imgui.SetNextWindowPos(imgui.ImVec2((sw/2),sh/2),imgui.Cond.FirstUseEver,imgui.ImVec2(0.5,0.5)) -- in center monitor
        imgui.Begin(u8'Главное меню',mws,imgui.WindowFlags.NoResize)
        
        if imgui.Button(u8'Настройки',btn_size) then
            sws.v = not sws.v 
            imwin = 0
        end
        imgui.AlignTextToFramePadding()
        
        if imgui.Button(u8'Биндер',btn_size) then bws.v = not bws.v; changeBind = nil;imwin = 32 end

        if imgui.Button(u8'Онлайн',btn_size) then ows.v = not ows.v end

        if imgui.Button('Fast Menu',btn_size) then fws.v = not fws.v end

        if imgui.Button(u8'Посты',btn_size) then pws.v = not pws.v end

        if imgui.Button(u8'Функции Скрипта',btn_size) then aws.v = not aws.v end

        if imgui.Button(u8'Отключить скрипт',btn_size) then thisScript():unload() end

        imgui.End()
    end

    if sws.v then
        
        imgui.SetNextWindowSize(imgui.ImVec2(550, 250), imgui.Cond.FirstUseEver) -- resoluthion window
        imgui.SetNextWindowPos(imgui.ImVec2((sw/2),sh/2),imgui.Cond.FirstUseEver,imgui.ImVec2(0.5,0.5))
        imgui.Begin(u8'Настройки',sws,imgui.WindowFlags.NoResize + imgui.WindowFlags.ShowBorders)

        imgui.BeginChild('Основные',imgui.ImVec2(80,215),true)

            if imgui.Selectable(u8'Основные') then imwin = 0 end
            if imgui.Selectable(u8'Инфо-Бар') then imwin = 1 end
            if imgui.Selectable(u8'Авто-БП') then imwin = 2 end
            if imgui.Selectable(u8'Цвет') then imwin = 3 end

        imgui.EndChild()

        imgui.SameLine()
        
        imgui.BeginChild(u8'Настройки',_,true)
            if imwin == 0 then

                if imadd.ToggleButton("##modr", useModRacia) then mainIni.config.modRacia = useModRacia.v end

                imgui.SameLine()

                imgui.Text(u8'Модифицированая Рация')

                if imadd.ToggleButton("##modm", useModMembers) then mainIni.config.modMembers = useModMembers.v end

                imgui.SameLine()

                imgui.Text(u8'Модифицированая Members')

                if imgui.Checkbox(u8'Открывать чат на Т',useChatT) then mainIni.settings.chatT = useChatT.v end

                if imgui.Checkbox(u8'Использовать Авто-тег',useAutoTeg) then mainIni.settings.autoTeg = useAutoTeg.v end

                if mainIni.settings.autoTeg then if imgui.InputText(u8'Введите ваш тег',inputRteg) then mainIni.config.rteg = u8:decode(inputRteg.v) end end

                if imgui.Checkbox(u8'Ставить метку на сигнал СОС',useMetka) then mainIni.settings.metka = useMetka.v end

                if imgui.Checkbox(u8'Использовать Авто-Клист',useAutoClist) then mainIni.settings.autoClist = useAutoClist.v end

                if mainIni.settings.autoClist then
                    imgui.SliderInt(u8"Номер клиста", numClist, 1, 33)
                    mainIni.config.acls = numClist.v
                    inicfg.save(mainIni,dcf)
                end

                imgui.Separator()

                inicfg.save(mainIni,dcf)
            elseif imwin == 1 then
                
                imgui.Text(u8'Использовать Инфо-Бар')

                imgui.SameLine()

                if imadd.ToggleButton("##infbr", useInfBr) then
                    mainIni.config.infbr = useInfBr.v
                    inicfg.save(mainIni,dcf)
                end

                imgui.Separator()


                if mainIni.config.infbr then

                    imgui.SliderInt(u8"Высота Инфо-Бара", infHeight, 30, 400)
                    infIni.sett.height = infHeight.v 

                    imgui.SliderInt(u8"Длина Инфо-Бара", infWeight, 235, 400)
                    infIni.sett.weight = infWeight.v 

                    imgui.SliderFloat(u8"Прозрачность", levelInvisiable, 0, 1)
                    infIni.sett.invisiable = levelInvisiable.v 
                    
                    imgui.SliderInt(u8"Округление", levelRounding, 0, 30)
                    infIni.sett.rounding = levelRounding.v 
                    
                    imgui.Text(u8'Показывать название скрипта')

                    imgui.SameLine()

                    if imadd.ToggleButton("##ustitle", useShowTitle) then infIni.sett.ShowTitle = useShowTitle.v end

                    imgui.Text(u8'Показывать ник')

                    imgui.SameLine()

                    if imadd.ToggleButton("##usn", useShowNick) then infIni.sett.ShowNick = useShowNick.v    end

                    imgui.Text(u8'Показывать HP и Armor')

                    imgui.SameLine()

                    if imadd.ToggleButton("##ust", useShowStut) then infIni.sett.ShowStut = useShowStut.v  end

                    imgui.Text(u8'Показывать ник цели')

                    imgui.SameLine()

                    if imadd.ToggleButton("##usT", useShowTarget) then infIni.sett.ShowTarget = useShowTarget.v end

                    imgui.Text(u8'Показывать информацию о оружие')

                    imgui.SameLine()

                    if imadd.ToggleButton("##usg", useShowGuns) then infIni.sett.ShowGuns = useShowGuns.v end

                    imgui.Text(u8'Показывать информация о состоянии машины')

                    imgui.SameLine()

                    if imadd.ToggleButton("##usc", useShowCar) then infIni.sett.ShowCar = useShowCar.v end

                    imgui.Text(u8'Показывать местонахождение')

                    imgui.SameLine()

                    if imadd.ToggleButton("##usC", useShowCord) then infIni.sett.ShowCord = useShowCord.v end

                    imgui.Text(u8'Показывать Дату')

                    imgui.SameLine()

                    if imadd.ToggleButton("##usd", useShowDate) then infIni.sett.ShowDate = useShowDate.v end

                    
                    imgui.Text(u8'Показывать отыграное время за сесию')

                    imgui.SameLine()

                    if imadd.ToggleButton("##uso", useShowOnline) then infIni.sett.ShowOnline = useShowOnline.v end

        
                    inicfg.save(infIni,dci)

                    if imgui.Button(u8'Изменить местоположение Инфо-Бара') then
                        mouseCord = true
                    end

                end
            elseif imwin == 2 then

                imgui.Text(u8'Использовать Авто-БП')

                imgui.SameLine()

                if imadd.ToggleButton("##autoBP", useAutoBP) then
                    mainIni.settings.autoBP = useAutoBP.v
                    inicfg.save(mainIni,dcf)
                end

                imgui.Separator()

                if mainIni.settings.autoBP then
                    imgui.Text(u8'Deagle')

                    imgui.SameLine()

                    if imadd.ToggleButton("##apbd", abpDeagle) then
                        mainIni.abp.deagle = abpDeagle.v
                        inicfg.save(mainIni,dcf)
                    end

                    imgui.Text(u8'Shotgun')

                    imgui.SameLine()

                    if imadd.ToggleButton("##apbs", abpShot) then
                        mainIni.abp.shot = abpShot.v
                        inicfg.save(mainIni,dcf)
                    end


                    imgui.Text(u8'SMG')

                    imgui.SameLine()

                    if imadd.ToggleButton("##apbSMG", abpSMG) then
                        mainIni.abp.smg = abpSMG.v
                        inicfg.save(mainIni,dcf)
                    end

                    imgui.Text(u8'M4')

                    imgui.SameLine()

                    if imadd.ToggleButton("##apbm", abpM4) then
                        mainIni.abp.m4 = abpM4.v
                        inicfg.save(mainIni,dcf)
                    end

                    imgui.Text(u8'Rifle')

                    imgui.SameLine()

                    if imadd.ToggleButton("##apbr", abpRifle) then
                        mainIni.abp.rifle = abpRifle.v
                        inicfg.save(mainIni,dcf)
                    end

                    imgui.Text(u8'Armour')

                    imgui.SameLine()

                    if imadd.ToggleButton("##apba", abpArmour) then
                        mainIni.abp.armour = abpArmour.v
                        inicfg.save(mainIni,dcf)
                    end

                    imgui.Text(u8'Парашут')

                    imgui.SameLine()

                    if imadd.ToggleButton("##apbp", abpSpec) then
                        mainIni.abp.spec = abpSpec.v
                        inicfg.save(mainIni,dcf)
                    end

                    imgui.Text(u8'Автоматически закрывать окно')

                    imgui.SameLine()

                    if imadd.ToggleButton("##apbc", abpClose) then
                        mainIni.abp.close = abpClose.v
                        inicfg.save(mainIni,dcf)
                    end
                end
            elseif imwin == 3 then
                if imgui.RadioButton(u8'Зеленый',StyleScript,0) then mainIni.settings.style = StyleScript.v end
                if imgui.RadioButton(u8'Синий',StyleScript,1) then mainIni.settings.style = StyleScript.v end
                if imgui.RadioButton(u8'Оранжевый',StyleScript,2) then mainIni.settings.style = StyleScript.v end
                if imgui.RadioButton(u8'Фиолетовый',StyleScript,3) then mainIni.settings.style = StyleScript.v end
                if imgui.RadioButton(u8'Серый',StyleScript,4) then mainIni.settings.style = StyleScript.v end
                if imgui.RadioButton(u8'Черная',StyleScript,5) then mainIni.settings.style = StyleScript.v end
                inicfg.save(mainIni,dcf)
            end
        imgui.EndChild()
        imgui.End()
    end

    if infbr.v then

        imgui.SetNextWindowPos(imgui.ImVec2(ISX,ISY),imgui.ImVec2(0.5,0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(tonumber(infIni.sett.weight), tonumber(infIni.sett.height)),imgui.Cond.Always)
        imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.06, 0.05, 0.07, infIni.sett.invisiable))
        imgui.PushStyleVar(imgui.StyleVar.WindowRounding, infIni.sett.rounding)
        imgui.Begin('Main Window',_,imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)

        if useShowTitle.v then
            imgui.CenterText('LVa Helper')

            imgui.Separator()

        end

        if infIni.sett.ShowNick then
            if MaskOn then
                imgui.TextColoredRGB(u8(string.format('Ник: {%s}%s{SSSSSS}[в маске]. Ваш ID: %s',MyColor,MyName,MyId)))
            else
                imgui.TextColoredRGB(u8(string.format('Ник: {%s}%s{SSSSSS}. Ваш ID: %s',MyColor,MyName,MyId)))
            end
        end
        
        if infIni.sett.ShowStut then imgui.Text(string.format('HP: %s. Armor: %s',MyHealth,MyArmor)) end

        if infIni.sett.ShowTarget then
            if valid and doesCharExist(ped) then
                _,TargetID = sampGetPlayerIdByCharHandle(ped)
                TargetName = sampGetPlayerNickname(TargetID)
                TargetHealth = sampGetPlayerHealth(TargetID)
                imgui.Text(u8(string.format('Цель: %s[%s] HP: %s',TargetName,TargetID,TargetHealth)))
            else
                imgui.Text(u8'Цель: Отсутсвует')
            end
        end

        if infIni.sett.ShowGuns then
            if weapons.get_name(IDweapon) == 'Fist' then
                imgui.Text(u8'Оружие: '..weapons.get_name(IDweapon))
            else
                imgui.Text(u8(string.format('Оружие: %s[%s/%s]',weapons.get_name(IDweapon),getAmmoInClip(),getAmmoInCharWeapon(PLAYER_PED, IDweapon)-getAmmoInClip())))
            end
        end

        if infIni.sett.ShowCar then
            if isCharInAnyCar(PLAYER_PED) then
                local IDcar = getCarModel(CarHandle)
                local CarHealth = getCarHealth(CarHandle)
                local CarSpeed = math.floor(getCarSpeed(CarHandle)*2)
                local CarName = CarsName[IDcar-399]
                imgui.Text(u8(string.format('Транспорт: %s | HP: %s | Скорость: %s',CarName,CarHealth,CarSpeed)))
            end
        end

        if infIni.sett.ShowCord then imgui.Text(u8'Местоположение: '..u8(kvadrat())) end

        if infIni.sett.ShowDate then imgui.Text(u8(os.date('Время: %H:%M:%S | %A %d.%m.%Y'))) end


        if useShowOnline.v then imgui.Text(u8'Отыграно: '..get_clock(sesionOnline)..' AFK: '..get_clock(afkTimeS)) end

        imgui.End()

        imgui.PopStyleVar()
        imgui.PopStyleColor()

    end


    if bws.v then

        imgui.ShowCursor = true

        imgui.SetNextWindowSize(imgui.ImVec2(780, 335), imgui.Cond.FirstUseEver) -- resoluthion window
        imgui.SetNextWindowPos(imgui.ImVec2((sw/2),sh/2),imgui.Cond.FirstUseEver,imgui.ImVec2(0.5,0.5)) -- in center monitor
        imgui.Begin(u8'Биндер',bws,imgui.WindowFlags.NoResize)
        imgui.BeginChild('Редактирование',imgui.ImVec2(640,280),true)
        i = 0
        if changeBind then
            if imwin == 32 then
                if binderIni[changeBind] then
                    levelBinder[1] = imgui.ImBuffer(u8(binderIni[changeBind].name),32) -- название
                    levelBinder[2] = imgui.ImBuffer(u8(binderIni[changeBind].act),24) -- команда активации
                    levelBinder[3] = imgui.ImBuffer(u8(binderIni[changeBind].wait),16) -- пауза
                    levelBinder[4] = imgui.ImBuffer(1024) -- редактор
                
                    for g = 1, 30 do
                        if binderIni[changeBind][g] == nil then
                            break
                        else
                            if g == 1 then
                                levelBinder[4].v = u8(binderIni[changeBind][g])
                            else
                                levelBinder[4].v = levelBinder[4].v .. "\n" .. u8(binderIni[changeBind][g])
                                levelBinder[4].v = levelBinder[4].v
                            end
                        end
                    end
                end
            elseif imwin == 33 then
                if binderIni['b'..changeBind] then
                    changeButton = {
                        v = decodeJson(binderIni['b'..changeBind].act)
                    }
                    
                    levelBinder[1] = imgui.ImBuffer(u8(binderIni['b'..changeBind].name),32) -- название
                    levelBinder[3] = imgui.ImBuffer(u8(binderIni['b'..changeBind].wait),16) -- пауза
                    levelBinder[4] = imgui.ImBuffer(1024) -- редактор
                
                    for g = 1, 30 do
                        if binderIni['b'..changeBind][g] == nil then
                            break
                        else
                            if g == 1 then
                                levelBinder[4].v = u8(binderIni['b'..changeBind][g])
                            else
                                levelBinder[4].v = levelBinder[4].v .. "\n" .. u8(binderIni['b'..changeBind][g])
                                levelBinder[4].v = levelBinder[4].v
                            end
                        end
                    end
                end
            end

            imgui.PushItemWidth(175)
            
            imgui.SetCursorPosX( 220,320)
            if imgui.InputText(u8"Название бинда", levelBinder[1]) then
                if imwin == 32 then binderIni[changeBind].name = u8:decode(levelBinder[1].v) end
                if imwin == 33 then binderIni['b'..changeBind].name = u8:decode(levelBinder[1].v) end
            end
            imgui.PopItemWidth()

            imgui.PushItemWidth(125)
            if imwin == 32 then
                if imgui.InputText(u8'Команда активации',levelBinder[2]) then
                    binderIni[changeBind].act = u8:decode(levelBinder[2].v)
                end
            elseif imwin == 33 then
                imgui.Text(u8'Кнопка активации: ')
                imgui.SameLine()
                if imgui.HotKey("###"..changeBind, changeButton, tLastKeys, 75) then
                    if ButtonActiveted then
                        rkeys.changeHotKey(ButtonActiveted, changeButton.v)
                    else
                        ButtonActiveted = rkeys.registerHotKey(changeButton.v, true,onHotKey)
                    end
                    binderIni['b'..changeBind].act = encodeJson(changeButton.v)
                end
            end
                
            imgui.SameLine()

            imgui.SetCursorPosX( 405,_)

            imgui.Text(u8'Задержка(в мс):')
            
            imgui.SameLine()

            imgui.SetCursorPosX( 505,_)

            if imgui.InputText(u8'##6',levelBinder[3]) then
                if imwin == 32 then binderIni[changeBind].wait = u8:decode(levelBinder[3].v) end
                if imwin == 33 then binderIni['b'..changeBind].wait = u8:decode(levelBinder[3].v) end
            end

            imgui.PopItemWidth()


            imgui.CenterText(u8'Редактор')
            imgui.InputTextMultiline('##2', levelBinder[4], imgui.ImVec2(640, 178))

            if imwin == 32 then
                for b = 1, 30 do
                    if binderIni[changeBind] ~= nil then
                        if binderIni[changeBind][b] ~= nil then
                            binderIni[changeBind][b] = nil
                        else
                            break
                        end
                    else
                        break
                    end
                end
            elseif imwin == 33 then
                for b = 1, 30 do
                    if binderIni['b'..changeBind] ~= nil then
                        if binderIni['b'..changeBind][b] ~= nil then
                            binderIni['b'..changeBind][b] = nil
                        else
                            break
                        end
                    else
                        break
                    end
                end
            end

            if imwin == 32 then
                for s in string.gmatch(u8:decode(levelBinder[4].v), "[^\r\n]+") do
                    i = i + 1
                    binderIni[changeBind][i] = s
                end
            elseif imwin == 33 then
                for s in string.gmatch(u8:decode(levelBinder[4].v), "[^\r\n]+") do
                    i = i + 1
                    binderIni['b'..changeBind][i] = s
                end
            end

            if imgui.Button(u8'Доп.Возможности') then dws.v = not dws.v end

            imgui.SameLine()

            imgui.TextQuestion("( ? )", u8"Что-бы закрыть окно,нажмите ещё раз на кнопку")

            imgui.SameLine()

            imgui.SetCursorPosX( 544,_)

            if imgui.Button(u8'Удалить бинд') then
                if imwin == 32 then
                    for i = 0,30 do
                        binderIni[changeBind][i] = nil
                    end
                    binderIni[changeBind].wait = nil
                    binderIni[changeBind].act = nil
                    binderIni[changeBind].name = nil
                    binderIni[changeBind] = nil
                    imgui.CloseCurrentPopup()
                elseif imwin == 33 then
                    for i = 0,30 do
                        binderIni['b'..changeBind][i] = nil
                    end
                    binderIni['b'..changeBind].wait = nil
                    binderIni['b'..changeBind].act = nil
                    binderIni['b'..changeBind].name = nil
                    binderIni['b'..changeBind] = nil
                    imgui.CloseCurrentPopup()
                end
                changeBind = nil
            end
            inicfg.save(binderIni,dcb)
        end

        imgui.EndChild()

        imgui.SameLine()

        imgui.BeginChild('Выбор',imgui.ImVec2(120,280),true)
            if imwin == 32 then
                for i = 0, line_binder + 10 do
                    if binderIni[i] then
                        if imgui.Selectable(u8(binderIni[i].name)) then changeBind = i end
                    end
                end
            elseif imwin == 33 then
                for i = 0, line_binder + 10 do
                    if binderIni['b'..i] then
                        if imgui.Selectable(u8(binderIni['b'..i].name)) then changeBind = i end
                    end
                end
            end
            if imgui.Button(u8'Добавить бинд') then
                if imwin == 32 then
                    for i = 1,line_binder + 10 do
                        if binderIni[i] == nil or binderIni[i] == '' then
                            binderIni[i] = {}
                            g = 'name'
                            binderIni[i][g] = 'Бинд №'..i
                            binderIni[i][1] = ''
                            binderIni[i].act = ''
                            binderIni[i].wait = 1000
                            inicfg.save(binderIni,dcb)
                            break
                        end
                    end
                elseif imwin == 33 then
                    for i = 1,line_binder + 10 do
                        if binderIni['b'..i] == nil or binderIni['b'..i] == '' then
                            binderIni['b'..i] = {}
                            g = 'name'
                            binderIni['b'..i][g] = 'Кнопка №'..i
                            binderIni['b'..i][1] = ''
                            binderIni['b'..i].act = '{}'
                            binderIni['b'..i].wait = 1000
                            inicfg.save(binderIni,dcb)
                            break
                        end
                    end
                end
            end
        imgui.EndChild()

        imgui.SetCursorPosX(330)
        if imwin == 32 then if imgui.Button(u8'Кнопочный биндер') then imwin = 33 changeBind = nil end end
        if imwin == 33 then if imgui.Button(u8'Командный биндер') then imwin = 32 changeBind = nil end end

        imgui.End()
    end


    if (dws.v and bws.v) or (dws.v and fws.v) then
        imgui.SetNextWindowPos(imgui.ImVec2((sw/2 + 385),(sh/2)-100),imgui.ImVec2(0.5,0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(300, 250), imgui.Cond.FirstUseEver)
        imgui.Begin('dop',_,imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
        if bws.v or dws.v then
            imgui.Text(u8(DopText))
        else
            dws.v = false
        end
        imgui.End()
    end


    if fastmenu then
        
        imgui.SetNextWindowPos(imgui.ImVec2(sw/2,sh/2))
        imgui.OpenPopup('PieMenu')
        if binderIni.fset.style == 0 then
            if pie.BeginPiePopup('PieMenu') then
                imgui.ShowCursor = true
                for i = 0,10 do
                    if binderIni['f'..i] then
                        if binderIni['f'..i].name then
                            if pie.BeginPieMenu(u8(binderIni['f'..i].name)) then
                                for z = 1,8 do
                                    if binderIni['f'..i]['names'..z] then
                                        if pie.PieMenuItem(u8(binderIni['f'..i]['names'..z])) then
                                            fastmenu = false
                                            lua_thread.create(function()
                                                for n = 1,30 do
                                                    if binderIni['f'..i][n..'x'..z] then
                                                        text = binderIni['f'..i][n..'x'..z]
                                                        for word in string.gmatch(text, "{(%a+)}") do
                                                            modBinder = ModerBinder()
                                                            if modBinder[word] then
                                                                text = string.gsub(text,'{'..word..'}',modBinder[word])
                                                            end
                                                        end
                                                        sampSendChat(text)
                                                        wait(binderIni['f'..i]['wait'..z])    
                                                    end
                                                end
                                            end)
                                        end
                                    end
                                end
                                pie.EndPieMenu()
                            end
                        end
                    end
                end
                if pie.PieMenuItem(u8'Отмена') then fastmenu = false end
                pie.EndPiePopup()
            end
        else
            if imgui.BeginPopup('PieMenu') then
                imgui.ShowCursor = true
                imgui.TextColoredRGB(string.format(u8'Цель: {%s}%s{SSSSSS}. ID[%s]',tcolor,TargetNick,tid))
                for i=0,10 do
                    if binderIni['f'..i] then
                        if binderIni['f'..i].name then
                            if imgui.BeginMenu(u8(binderIni['f'..i].name)) then
                                for z = 1,20 do
                                    if binderIni['f'..i]['names'..z] then
                                        if imgui.Selectable(u8(binderIni['f'..i]['names'..z])) then
                                            fastmenu = false
                                            lua_thread.create(function()
                                                for n = 1,30 do
                                                    if binderIni['f'..i][n..'x'..z] then
                                                        text = binderIni['f'..i][n..'x'..z]
                                                        for word in string.gmatch(text, "{(%a+)}") do
                                                            if modBinder[word] then
                                                                text = string.gsub(text,'{'..word..'}',modBinder[word])
                                                            end
                                                        end
                                                        sampSendChat(text)
                                                        wait(binderIni['f'..i]['wait'..z])    
                                                    end
                                                end
                                            end)
                                        end
                                    end
                                end
                                imgui.EndMenu()
                            end
                        end
                    end
                end
                if imgui.MenuItem(u8'Отмена') then fastmenu = false end
                imgui.EndPopup()
            end
        end
    end

    if ows.v then
        imgui.SetNextWindowSize(imgui.ImVec2(550, 250), imgui.Cond.FirstUseEver) -- resoluthion window
        imgui.SetNextWindowPos(imgui.ImVec2((sw/2),sh/2),imgui.Cond.FirstUseEver,imgui.ImVec2(0.5,0.5)) -- in center monitor
        imgui.Begin(u8'Онлайн',ows,imgui.WindowFlags.NoResize)
        imgui.BeginChild('days',imgui.ImVec2(350,215),true)
            imgui.BeginChild('day',imgui.ImVec2(120,150))
                imgui.Text(u8'День:')
                for i =1,#dayName do
                    imgui.Text(u8(dayName[i]))
                end
            imgui.EndChild()

            imgui.SameLine()


            imgui.BeginChild('onl',imgui.ImVec2(120,150))
                imgui.Text(u8'Онлайн:')
                for i = 1,#dayNameS do
                    imgui.Text(u8(get_clock(onlineIni.day[dayNameS[i]..'Onl'])))
                end
            imgui.EndChild()

            imgui.SameLine()


            imgui.BeginChild('afk')
                imgui.Text(u8'AFK:')
                for i = 1,#dayNameS do
                    imgui.Text(u8(get_clock(onlineIni.day[dayNameS[i]..'AFK'])))
                end
            imgui.EndChild()
        imgui.EndChild()

        imgui.SameLine()

        imgui.BeginChild('weekANDsesion',imgui.ImVec2(180,215))
            imgui.BeginChild('sesion',imgui.ImVec2(180,106),true)
                imgui.CenterText(u8'За сесию:')
                imgui.Text(u8'Онлайн: '..u8(get_clock(sesionOnline)))
                imgui.Text('AFK: '..u8(get_clock(afkTimeS)))
                imgui.Text(u8'Всего: '..u8(get_clock((afkTimeS+sesionOnline))))
            imgui.EndChild()

            imgui.BeginChild('week',imgui.ImVec2(180,105),true)
            imgui.CenterText(u8'За неделю:')
            imgui.Text(u8'Онлайн: '..u8(get_clock(onlineIni.week.onl)))
            imgui.Text('AFK: '..u8(get_clock(onlineIni.week.afk)))
            imgui.Text(u8'Всего: '..u8(get_clock((onlineIni.week.afk+onlineIni.week.onl))))
            imgui.EndChild()
        imgui.EndChild()
        
        imgui.End()
    end


    if fws.v then
        imgui.SetNextWindowSize(imgui.ImVec2(660, 320), imgui.Cond.FirstUseEver) -- resoluthion window
        imgui.SetNextWindowPos(imgui.ImVec2((sw/2),sh/2),imgui.Cond.FirstUseEver,imgui.ImVec2(0.5,0.5)) -- in center monitor
        width = imgui.GetWindowWidth()
        imgui.Begin(u8'Fast Menu редактор',fws)
        imgui.SameLine(150)
        imgui.BeginChild('styleANDact',imgui.ImVec2(350,50))
            imgui.BeginChild('style',imgui.ImVec2(170,40))
                imgui.CenterText(u8'Стиль Fast-Menu')
                if imgui.RadioButton(u8('Круглое'),fastStyle,0) then binderIni.fset.style = fastStyle.v end
                imgui.SameLine()
                if imgui.RadioButton(u8('Квадратное'),fastStyle,1) then binderIni.fset.style = fastStyle.v end
            imgui.EndChild()
            imgui.SameLine()
            imgui.BeginChild('actfast',imgui.ImVec2(145,40))
                imgui.SameLine(10)
                imgui.Text(u8'Активация Fast Menu')
                imgui.Text(u8'       ПКМ + ')
                imgui.SameLine()
                if imgui.HotKey("##1", ActiveFastMenu, tLastKeys, 50) then
                    rkeys.changeHotKey(ActiveFast, ActiveFastMenu.v)
                    binderIni.fset.act = encodeJson(ActiveFastMenu.v)
                end
            imgui.EndChild()
        imgui.EndChild()
        imgui.Separator()
        for i = 1,10 do
            if binderIni['f'..i] then
                FastMenuMasive[0] = u8('Не выбрано')
                FastMenuMasive[i] = u8(binderIni['f'..i].name)
            end
        end
        imgui.PushItemWidth(150)
        if imgui.Combo(u8'Выберите бинд', FastMenuEdit1, FastMenuMasive,#FastMenuMasive + 1) then changeBind = false end
        if FastMenuEdit1.v then
            i = FastMenuEdit1.v
            if binderIni['f'..i] then
                levelBinder[1] = imgui.ImBuffer(u8(binderIni['f'..i].name),32) -- название bind'a
                levelBinder[5] = imgui.ImBuffer(1024)

                imgui.SameLine(390)
                if imgui.InputText(u8"Название бинда", levelBinder[1]) then
                    binderIni['f'..i].name = u8:decode(levelBinder[1].v)
                end
                imgui.CenterText(u8'Под меню бинда')
                for z = 1, 20 do
                    if binderIni['f'..i]['names'..z] then
                        if imgui.Button(u8(binderIni['f'..i]['names'..z])) then
                            changeBind = z
                        end
                        imgui.SameLine()
                    end
                end
                if imgui.Button(u8'Добавить под-меню') then
                    for b = 1,line_binder do
                        if binderIni['f'..i]['names'..b] == nil or binderIni['f'..i]['names'..b] == '' then
                            binderIni['f'..i]['names'..b] = 'Под Меню №'..b
                            binderIni['f'..i]['wait'..b] = 1000
                            break
                        end
                    end
                end
                v=0
                if changeBind then
                    if binderIni['f'..i] then
                        if binderIni['f'..i]['names'..changeBind] then
                            levelBinder[2] = imgui.ImBuffer(u8(binderIni['f'..i]['names'..changeBind]),32)
                            levelBinder[3] = imgui.ImBuffer(u8(binderIni['f'..i]['wait'..changeBind]),16)
                        end
                        if imgui.InputText(u8"Название под меню", levelBinder[2]) then
                            binderIni['f'..i]['names'..changeBind] = u8:decode(levelBinder[2].v)
                        end

                        imgui.SameLine(390)

                        imgui.Text(u8'Задержка(в мс):')

                        imgui.SameLine()

                        if imgui.InputText('##b10', levelBinder[3]) then
                            binderIni['f'..i]['wait'..changeBind] = u8:decode(levelBinder[3].v)
                        end

                        for g = 1, 30 do
                            if binderIni['f'..i][g..'x'..changeBind] == nil then
                                break
                            else
                                if g == 1 then
                                    levelBinder[5].v = u8(binderIni['f'..i][g..'x'..changeBind])
                                else
                                    levelBinder[5].v = levelBinder[5].v .. "\n" .. u8(binderIni['f'..i][g..'x'..changeBind])
                                    levelBinder[5].v = levelBinder[5].v
                                end
                            end
                        end
                        imgui.InputTextMultiline("##5", levelBinder[5],imgui.ImVec2(650,130))
                        for s in string.gmatch(u8:decode(levelBinder[5].v), "[^\r\n]+") do
                            v = v + 1
                            binderIni['f'..i][v..'x'..changeBind] = s
                        end
                        if imgui.Button(u8'Доп.Возможности') then
                            dws.v = not dws.v
                        end
                        imgui.SameLine(525)
                        if imgui.Button(u8'Удалить под меню') then
                            for d = 1,20 do
                                binderIni['f'..i][d..'x'..changeBind] = nil
                            end
                            binderIni['f'..i]['wait'..changeBind] = nil
                            binderIni['f'..i]['names'..changeBind] = nil
                            changeBind = false
                        end
                    end
                end

                imgui.Separator()
            end
        end
        if imgui.Button(u8'Добавить бинд') then
            for i = 1,line_binder + 10 do
                if binderIni['f'..i] == nil or binderIni['f'..i] == '' then
                    binderIni['f'..i] = {}
                    binderIni['f'..i].name = 'Бинд №'..i
                    break
                end
            end
        end
        imgui.SameLine(555)
        if FastMenuEdit1.v ~= 0 then
            i = FastMenuEdit1.v
            if imgui.Button(u8'Удалить бинд') then
                if binderIni['f'..i] then
                    binderIni['f'..i] = nil
                    FastMenuEdit1.v = 0
                    table.remove(FastMenuMasive,i)
                end
            end
        end
        imgui.PopItemWidth()
        inicfg.save(binderIni,dcb)
        imgui.End()
    end

    if pws.v then
        imgui.SetNextWindowSize(imgui.ImVec2(600, 400), imgui.Cond.FirstUseEver) -- resoluthion window
        imgui.SetNextWindowPos(imgui.ImVec2((sw/2),sh/2),imgui.Cond.FirstUseEver,imgui.ImVec2(0.5,0.5)) -- in center monitor
        imgui.Begin(u8'Посты',pws,imgui.WindowFlags.NoResize)
        if postIni then
            for i = 1,20 do
                if postIni[i] then
                    if postIni[i].name then
                        if isCharInArea2d(PLAYER_PED,postIni[i].posx1,postIni[i].posy1,postIni[i].posx2,postIni[i].posy2) then
                            imgui.CenterText(u8(postIni[i].name..' (+)'))
                        else
                            imgui.CenterText(u8(postIni[i].name))
                        end
                        imgui.SameLine(495)

                        if imgui.Button(u8'Изменить #'..i,btn_size) then
                            changeBind = i
                        end
                    end
               
                end
            end
            if imgui.Button(u8'Добавить пост',btn_size) then
                for i=1,20 do
                    if postIni[i] == nil or postIni[i] == '' then
                        postIni[i] = {}
                        
                        postIni[i].name = 'Пост №'..i
                        postIni[i].posx1=0
                        postIni[i].posx2=0
                        postIni[i].posy1=0
                        postIni[i].posy2=0
                        break
                    end
                end
            end
            imgui.Separator()
            if changeBind then
                imgui.PushItemWidth(150)
                saveX, saveY, saveZ = getCharCoordinates(PLAYER_PED)

                inputPosX1 = imgui.ImBuffer(tostring(postIni[changeBind].posx1),16)
                inputPosX2 = imgui.ImBuffer(tostring(postIni[changeBind].posx2),16)
                inputPosY1 = imgui.ImBuffer(tostring(postIni[changeBind].posy1),16)
                inputPosY2 = imgui.ImBuffer(tostring(postIni[changeBind].posy2),16)
                inputPosName = imgui.ImBuffer(u8(postIni[changeBind].name),16)
                
                if imgui.InputText(u8'Название поста',inputPosName) then postIni[changeBind].name = u8:decode(inputPosName.v) end

                imgui.SameLine(495)

                if imgui.Button(u8'Удалить пост',btn_size) then
                    postIni[changeBind].posx1 = nil
                    postIni[changeBind].posx2 = nil
                    postIni[changeBind].posy1 = nil
                    postIni[changeBind].posy2 = nil
                    postIni[changeBind].name = nil
                    postIni[changeBind] = nil
                    changeBind = false
                end

                if imgui.InputText(u8'X1',inputPosX1) then postIni[changeBind].posx1 = inputPosX1.v end
                
                imgui.SameLine()
                
                if imgui.InputText(u8'Y1',inputPosY1) then postIni[changeBind].posy1 = inputPosY1.v end
                
                if imgui.Button(u8'Сохранить точку №1') then
                    postIni[changeBind].posx1 = saveX
                    postIni[changeBind].posy1 = saveY
                end
                
                if imgui.InputText(u8'X2',inputPosX2) then postIni[changeBind].posx2 = inputPosX2.v end
                
                imgui.SameLine()
                
                if imgui.InputText(u8'Y2',inputPosY2) then postIni[changeBind].posy2 = inputPosY2.v end
                
                if imgui.Button(u8'Сохранить точку №2') then
                    postIni[changeBind].posx2 = saveX
                    postIni[changeBind].posy2 = saveY
                end

                imgui.TextQuestion("( ? )", u8"Точки надо сохранять по диагонали друг от друга")

                imgui.SameLine(530)
                if imgui.Button(u8'Отмена',btn_size) then changeBind = false end
                imgui.PopItemWidth()
            end
            inicfg.save(postIni,dcp)
        end
        imgui.SetCursorPosX(130)
        imgui.BeginChild('statPost',imgui.ImVec2(350,80),true)
            imgui.CenterText(u8'Статистика')
            imgui.Text(u8(string.format('За неделю     Докладов: %s. Проверено паспортов: %s',postIni.stat.weakDoklad,postIni.stat.weakPass)))
            imgui.Text(u8(string.format('За сесию       Докладов: %s. Проверено паспортов: %s',sessionDoklad,sessionPass)))

        imgui.EndChild()
        imgui.SetCursorPosX(130)
        imgui.BeginChild('settPost',imgui.ImVec2(350,100),true)
            imgui.SetCursorPosX(90)
            if imgui.Button(u8'Изменить местоположение') then mouseCordPost = true end
            imgui.PushItemWidth(250)
            imgui.Text('')
            if imgui.SliderFloat(u8"Прозрачность", levelInvisiablePost, 0, 1) then
                postIni.sett.invisiable = levelInvisiablePost.v
                if not patrul then patrul = true end
            end 
            
            if imgui.SliderInt(u8"Округление", levelRoundingPost, 0, 30) then
                postIni.sett.rounding = levelRoundingPost.v
                if not patrul then patrul = true end
            end
            imgui.PopItemWidth()
            inicfg.save(postIni,dcp)

        imgui.EndChild()
        imgui.End()
    end


    if patrul then
        imgui.SetNextWindowSize(imgui.ImVec2(320, 100), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowPos(imgui.ImVec2(postIni.sett.x,postIni.sett.y),imgui.ImVec2(0.5,0.5))
        imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.06, 0.05, 0.07, postIni.sett.invisiable))
        imgui.PushStyleVar(imgui.StyleVar.WindowRounding, postIni.sett.rounding)
        imgui.Begin('ssssss',patrul,imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
        for i = 1,20 do
            if postIni[i] then
                if isCharInArea2d(PLAYER_PED,postIni[i].posx1,postIni[i].posy1,postIni[i].posx2,postIni[i].posy2) then
                    post = postIni[i].name
                    z = i
                    break
                end
            end
        end
        
        if z then
            if isCharInArea2d(PLAYER_PED,postIni[z].posx1,postIni[z].posy1,postIni[z].posx2,postIni[z].posy2) then
                imgui.Text(u8'Пост: '..u8(post))
            else
                imgui.Text(u8'Пост: Не определено')
            end
        else
            imgui.Text(u8'Пост: Не определено')
        end
        imgui.Text(u8'Время на посту: '..get_clock(timePatrule)..' AFK: '..get_clock(afkPatrule))
        imgui.Text(u8'Количество докладов: '..timesDoklad)
        imgui.Text(u8'Проверено паспортов: '..checkPass)
        imgui.Text(tostring(timeDoklad))
        imgui.End()
        imgui.PopStyleVar()
        imgui.PopStyleColor()
    end

    if aws.v then
        imgui.SetNextWindowSize(imgui.ImVec2(400, 200), imgui.Cond.FirstUseEver) 
        imgui.SetNextWindowPos(imgui.ImVec2((sw/2),sh/2),imgui.Cond.FirstUseEver,imgui.ImVec2(0.5,0.5))
        imgui.Begin(u8'Функции Скрипта',aws)
        
        imgui.CenterText(u8'Команды скрипта')

        imgui.TextColoredRGB(u8'{51964D}/lv{SSSSSS} - активация скрипта')
        imgui.TextColoredRGB(u8'{51964D}/getm{SSSSSS} (0/1) - мониторинг складов')
        imgui.TextColoredRGB(u8'{51964D}/post{SSSSSS} (start/stop) - начать счетчик активности на посту')
        imgui.TextColoredRGB(u8'{51964D}/logdep{SSSSSS} - посмотреть последние 25 сообщений в департамент')
        imgui.TextColoredRGB(u8'{51964D}/logsms{SSSSSS} - посмотреть последние 25 сообщений в SMS')


        imgui.End()
    end

    if uws.v then

        imgui.ShowCursor = true

        imgui.SetNextWindowSize(imgui.ImVec2(370, 130), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowPos(imgui.ImVec2(sw/2,sh/2),imgui.Cond.FirstUseEver,imgui.ImVec2(0.5,0.5))
        imgui.Begin(u8'Обновление',uws)

        imgui.CenterText(u8(string.format('Доступно обновление до версии %s.',info.latest)))
        imgui.CenterText(u8('Изменения: '..info.changes))
        imgui.CenterText(u8'Обновить сейчас?')

        if imgui.Button(u8'Да',imgui.ImVec2(175,25)) then 
            uws.v = false 
            sampAddChatMessage(sname..'Началось обновление скрипта',-1)
            link = info.updateurl
            path = getWorkingDirectory()..'\\LVaHelper.lua'
            downloadUrlToFile(link, path, download_handler)
        end
        imgui.SameLine()
        if imgui.Button(u8'Нет',imgui.ImVec2(175,25)) then print('Обновление отклонено') uws.v = false end
 
        imgui.End()
    end

end



------------------------------

function main()
    if not isSampLoaded() then return end
    while not isSampAvailable() do wait(0) end

    local _,MyId = sampGetPlayerIdByCharHandle(PLAYER_PED)
    local MyName = sampGetPlayerNickname(MyId)

    mainDirectory = getWorkingDirectory()..'\\cfg\\'..MyName

    dcf = mainDirectory..'\\config.ini'
    mainIni = inicfg.load(nil,dcf)
    
    dcb = mainDirectory..'\\binder.ini'
    binderIni = inicfg.load(nil,dcb)

    dco = mainDirectory..'\\online.ini'
    onlineIni = inicfg.load(nil,dco)

    dci = mainDirectory..'\\infbar.ini'
    infIni = inicfg.load(nil,dci)

    dcp = mainDirectory..'\\post.ini'
    postIni = inicfg.load(nil,dcp)

    if doesFileExist(dcf) then
        apply_custom_style(mainIni.settings.style)
    else
        apply_custom_style(0)
    end


    buttonbind = {}
    if doesFileExist(dcb) then
        ActiveFastMenu = {
            v = decodeJson(binderIni.fset.act)
        }
        ActiveFast = rkeys.registerHotKey(ActiveFastMenu.v, true, actfast)
        for i=1,line_binder do
            if binderIni['b'..i] then
                if binderIni['b'..i].act ~= '{}' or binderIni['b'..i].act ~= '' then 
                    table.insert(buttonbind,{v=binderIni['b'..i].act,z=i})
                end
            end
        end
        for k, v in ipairs(buttonbind) do
            ButtonActiveted = rkeys.registerHotKey(decodeJson(v.v), true,onHotKey)
        end

    end

    updateTime()

    checkDirectory(MyName)

    sampAddChatMessage(sname..'Скрипт загружен. Активация {51964D}/lv{ffffff}',-1)



    sampRegisterChatCommand('lv',function()
        mws.v = not mws.v
        if imgui.Process then
            
        else
            imgui.Process = mws.v
        end
    end)
    sampRegisterChatCommand('logdep',cmd_logdep)
    sampRegisterChatCommand('logsms',cmd_logsms)
    sampRegisterChatCommand('getm',cmd_getm)
    sampRegisterChatCommand('post',cmd_post)
    sampRegisterChatCommand('findkv',cmd_findkv)

    while not sampIsLocalPlayerSpawned() do wait(0) end
    
    check_stats()

    startTime = os.time()

    
    if doesFileExist(dcf) then
        if mainIni.settings then
            if mainIni.settings.autoTeg then
                sampRegisterChatCommand('r',cmd_f) 
            else
                sampUnregisterChatCommand('r')
            end
        end
    else
        checkDirectory(MyName)
    end


    if mainIni.config.infbr then
        imgui.Process = true
        imgui.ShowCursor = false
    end

    lua_thread.create(time)


    while true do

        if doesFileExist(dcf) then
            apply_custom_style(mainIni.settings.style)
        else
            apply_custom_style(0)
        end



        if doesFileExist(dcf) then
            mainIni = inicfg.load(nil,dcf)
            if mainIni.settings.chatT then
                if isKeyJustPressed(key.VK_T) then
                    if not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive()  then
                        sampSetChatInputEnabled(true)
                    end
                end
            end
        end


        if (mainIni.config.infbr and patrul) or mainIni.config.infbr or patrul then
            imgui.ShowCursor = false
        end

        if patrul then
            if z then
                if isCharInArea2d(PLAYER_PED,postIni[z].posx1,postIni[z].posy1,postIni[z].posx2,postIni[z].posy2) then
                    if tonumber(timeDoklad) >= 60 then
                        timeDoklad = 0
                    end
                    if (tonumber(os.date('%M')) >= tonumber(timeDoklad) and os.date('%M') % 5 == 0 and tonumber(timeDoklad) ~= 00) or (tonumber(timeDoklad) == 00 and tonumber(os.date('%M'))==tonumber(timeDoklad)) then

                        postSostav = 1
                        for i = 0, sampGetMaxPlayerId(true) do
                            local bool, playerHandle = sampGetCharHandleBySampPlayerId(i)
                            if bool and doesCharExist(playerHandle) then
                                if isCharInArea2d(playerHandle,postIni[z].posx1,postIni[z].posy1,postIni[z].posx2,postIni[z].posy2) then
                                    local playerskin = getCharModel(playerHandle)
                                    if playerskin == 287 or playerskin == 191 or playerskin == 179 or playerskin == 61 or playerskin == 255 or playerskin == 73 then
                                        postSostav = postSostav + 1
                                    end
                                end
                            end
                        end

                        sampSendChat(string.format('/r %s Докладываю: | Пост: %s | Состав: %s | Состояние: Стабильное',mainIni.config.rteg,postIni[z].name,postSostav))
                        timesDoklad = timesDoklad + 1
                        postIni.stat.weakDoklad = postIni.stat.weakDoklad + 1
                        sessionDoklad = sessionDoklad + 1 
                        if tonumber(timeDoklad) >= 55 or tonumber(timeDoklad) >= 60 then
                            timeDoklad = 00
                        else
                            timeDoklad = os.date('%M') + 5
                        end
                    end
                end
            end
        end

        for i=1,line_binder do
            if binderIni['b'..i] then
                if binderIni['b'..i].act ~= '{}' or binderIni['b'..i].act ~= '' then 
                    table.insert(buttonbind,{v=binderIni['b'..i].act,z=i})
                end
            end
        end

        if mouseCord then
			sampToggleCursor(true)
			CPX, CPY = getCursorPos()
			infIni.sett.x = CPX
            infIni.sett.y = CPY
            if imgui.IsMouseClicked(0) and mouseCord then
                sampToggleCursor(false)
                mouseCord = false
                imgui.Process = true
            end
            inicfg.save(infIni,dci)
		end

        if mouseCordPost then
            patrul = true
			sampToggleCursor(true)
			CPX, CPY = getCursorPos()
			postIni.sett.x = CPX
            postIni.sett.y = CPY
            if imgui.IsMouseClicked(0) and mouseCordPost then
                sampToggleCursor(false)
                patrul = false
                mouseCordPost = false
                imgui.Process = true
            end
            inicfg.save(postIni,dcp)
		end

        wait(0)
    end
end

function onHotKey(id,keys)
    for i = 1,20 do
        if binderIni['b'..i] then
            if encodeJson(keys) == binderIni['b'..i].act then
                lua_thread.create(function()
                    if sampIsChatInputActive() or sampIsDialogActive() or isSampfuncsConsoleActive() then

                    else
                        if binderIni['b'..i] then
                            for z =1,#binderIni['b'..i] do
                                text = binderIni['b'..i][z]
                                for word in string.gmatch(text, "{(%a+)}") do
                                    modBinder = ModerBinder()
                                    if modBinder[word] then
                                        text = string.gsub(text,'{'..word..'}',modBinder[word])
                                    end
                                end
                                sampSendChat(text)
                                wait(binderIni['b'..i].wait)
                            end
                        end
                    end
                end)
            end
        end
    end
end

function cmd_logdep()
    textdep = ''
    color = -8224086
    color = string.format('%06x', bit.rshift(color, 8))
    for i = 1,#departamentlog do
        if i == 1 then
            textdep = departamentlog[i]
        else
            textdep = textdep..'\n'..departamentlog[i]
        end
    end
    sampShowDialog(666, 'История сообщей департамента','{'..color..'}'..textdep, 'Закрыть', _, 0)
end

function cmd_logsms()
    textsms = ''
    color = -65366
    color = string.format('%06x', bit.rshift(color, 8))
    for i = 1,#smslog do
        if i == 1 then
            textsms = smslog[i]
        else
            textsms = textsms..'\n'..smslog[i]
        end
    end
    sampShowDialog(6666, 'История SMS сообщений','{'..color..'}'..textsms, 'Закрыть', _, 0)
end

function actfast()
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE) 
    if valid and doesCharExist(ped) then 
        result, id = sampGetPlayerIdByCharHandle(ped) 
        if result then
            tid = id
            tname = sampGetPlayerNickname(id):gsub('_', ' ') 
            tcolor = string.format("%06X", ARGBtoRGB(sampGetPlayerColor(id))) 
            fastmenu = true
            imgui.Process = fastmenu
        end
    end
end

function cmd_post(arg)
    if arg == 'start' then
        patrul = true
        if not imgui.Process then imgui.Process = true end
        timeDoklad = os.date('%M')
        if tonumber(timeDoklad) >= 56 then timeDoklad = 0 end
        patrulstart = os.time()
    elseif arg == 'stop' then
        patrulend = os.time() - patrulstart
        fulltimepatrul = nil
        timePatrule = 0
        afkPatrule = 0
        patrulstart = false
        sampAddChatMessage(sname..string.format('Вы покинули пост.Время на посту: %s.Сделано докладов: %s.Проверено паспортов: %s',get_clock(patrulend),timesDoklad,checkPass),-1)
        patrul = false
    else
        sampAddChatMessage(sname..'Введите /post start/stop',-1)
        sampAddChatMessage(sname..'start - начать считать статистику на посту | stop - закончить считать',-1)
    end
end

function time()
    while true do
        wait(1000)
        sesionOnline = sesionOnline + 1
        sesionOnline1 = sesionOnline1 + 1
        onlineIni.week.onl = onlineIni.week.onl + 1
        onlineIni.day[os.date('%a')..'Onl'] = onlineIni.day[os.date('%a')..'Onl'] + 1
        fullTime = os.time() - startTime
        afkTime = fullTime - sesionOnline
        afkTimeS = fullTime - sesionOnline1
        onlineIni.day[os.date('%a')..'AFK'] = onlineIni.day[os.date('%a')..'AFK'] + afkTime
        onlineIni.week.afk = onlineIni.week.afk + afkTime
        sesionOnline = sesionOnline + afkTime

        -------- post --------

        if patrulstart then
            fulltimepatrul = os.time() - patrulstart
            timePatrule = timePatrule + 1
            afkPatrule = fulltimepatrul - timePatrule
        end

        inicfg.save(onlineIni,dco)
    end
end

function updateTime() 
    if doesFileExist(dco) then
        if tonumber(onlineIni.week.weak) ~= tonumber(os.date('%W')) then
            text = string.format(sname..'Началась новая неделя. За предыдущую неделю отыграли %s',get_clock((onlineIni.week.onl + onlineIni.week.afk)))
            sampAddChatMessage(text,-1)
            for i = 1,#dayNameS do
                onlineIni.day[dayNameS[i]..'Onl'] = 0
                onlineIni.day[dayNameS[i]..'AFK'] = 0
            end
            onlineIni.week.onl = 0
            onlineIni.week.afk = 0
            onlineIni.week.weak = os.date('%W')
        end
        inicfg.save(onlineIni,dco)
    end
end


function cmd_f(arg)
    sampSendChat('/r '..mainIni.config.rteg..' '..arg)
end


function check_stats()
    lua_thread.create(function()
        while not sampIsLocalPlayerSpawned() do wait(0) end
        wait(100)
        sampSendChat('/stats')
        while not sampIsDialogActive() or sampGetCurrentDialogId() ~= 9901 do wait(0) end
        textDialog = sampGetDialogText()
        MyName = textDialog:match('Имя%s+(%a+_%a+)')

        frac = textDialog:match('Организация%s+(.-)\n')
        full= textDialog:match('Должность%s+(.-)\n')
        idRang,nameRang = full:match('(%d+) %((.+)%)')        
        sex = textDialog:match('Пол%s+(.-)\n')

        sampCloseCurrentDialogWithButton(0)
        
        mainIni.config.fraction = frac
        mainIni.config.rangName = nameRang
        mainIni.config.sex = sex

        if inicfg.save(mainIni,dcf) then
            print('Информация обновлена')
        end
    end)
end

------ function in imgui ------
function imgui.TextQuestion(label, description)
    imgui.TextDisabled(label)

    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
            imgui.PushTextWrapPos(600)
                imgui.TextUnformatted(description)
            imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end


function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
end

function imgui.TextColoredRGB(text)
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end

    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImColor(r, g, b, a):GetVec4()
    end

    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], text[i])
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else imgui.Text(w) end
        end
    end

    render_text(text)
end



---- sampev ------
function sampev.onSendSpawn()
    local myskin = getCharModel(PLAYER_PED)
    if myskin == 287 or myskin == 191 or myskin == 179 or myskin == 61 or myskin == 255 or myskin == 73 then
        rabden = true
    end
    if rabden then
        if mainIni.settings.autoClist then
            lua_thread.create(function()
            wait(100)
            sampSendChat('/clist '..mainIni.config.acls)
            sampAddChatMessage(sname..'Клист изменён',-1)
            end)
        end
    end
end


function sampev.onShowDialog(dialogID, style, title, button1, button2, text)
    if dialogID == 20053 then
       GetAutoBP()
    end
end

function sampev.onSendCommand(command)
    for i = 1,line_binder do
        if binderIni[i] then
            if binderIni[i].act:find('/') then
                act = binderIni[i].act
            else
                act = '/'..binderIni[i].act
            end
            if act == command then
                lua_thread.create(function()
                    for s = 1,#binderIni[i] do
                        text = binderIni[i][s]
                        for word in string.gmatch(text, "{(%a+)}") do
                            modBinder = ModerBinder()
                            if modBinder[word] then
                                text = string.gsub(text,'{'..word..'}',modBinder[word])
                            end
                        end
                        sampAddChatMessage(text,-1)
                        wait(binderIni[i].wait)
                    end
                end)
            end
        end
    end
end


function sampev.onServerMessage(color, text)

    local _,MyId = sampGetPlayerIdByCharHandle(PLAYER_PED)
    local MyName = sampGetPlayerNickname(MyId)

    dcf = getWorkingDirectory()..'\\cfg\\'..MyName..'\\config.ini'
    mainIni = inicfg.load(nil,dcf)

    dcp = getWorkingDirectory()..'\\cfg\\'..MyName..'\\post.ini'
    postIni = inicfg.load(nil,dcp)

    if text:find('PASSPORT') then
        checkPass = checkPass + 1
        sessionPass = sessionPass + 1
        postIni.stat.weakPass = postIni.stat.weakPass + 1
        inicfg.save(postIni,dcp) 
    end

    if mainIni.config.metka then
        if (text:find('SOS') or text:find('sos') or text:find('СОС') or text:find('сос') ) and text:match("(%A)-(%d+)") and not text:find(MyName) then
            kvx,kvy = text:match("(%A)-(%d+)")
            cmd_findkv(kvx..'-'..kvy)
        end
    end

    if doesFileExist(dcf) then
        if text:find('Рабочий день начат') then
            if mainIni.settings.autoClist then
                lua_thread.create(function()
                    wait(100)
                    sampSendChat('/clist '..mainIni.config.acls)
                    sampAddChatMessage(sname..'Клист изменён',-1)
                end)
            end
        end

        if text:find('Вы надели маску') then MaskOn = true end 

        if text:find('Вы сняли с себя маску') then
            lua_thread.create(function()
                MaskOn = false
                wait(100)
                sampSendChat('/clist '..mainIni.config.acls)
                sampAddChatMessage(sname..'Клист изменён',-1)
            end)
        end

        if mainIni.config.modRacia then
            if color == 33357768 or color == -1920073984 and not text:find('отобрал рацию у') and not text:find('вернул рацию ') then
                local mod = text:match('(%S+): .+'):gsub(" ", "")
                if string.match(mod,'(%a+_%a+).(%d+)') then
                    nick,id = string.match(mod,'(%a+_%a+).(%d+)')
                    colors = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
                    text = text:gsub(nick, ("{8D8DFF}{%s}%s {%s}"):format(colors, nick, ("%06X"):format(bit.rshift(color, 8))))
                else
                    id = sampGetPlayerIdByNickname(mod)
                    text = text:gsub(mod, ("{8D8DFF}{%s}%s [%s]{%s}"):format(("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF)), mod,id, ("%06X"):format(bit.rshift(color, 8))))
                end
                return {color,text}
            end
        end
        if mainIni.config.modMembers then
            if text:match('ID: .+ | .+ | .+: .+ %- .+') or text:match('ID: .+ | .+ | .+: .+') then
                if text:match('ID: .+ | .+ | .+: .+ %- .+') then
                    id, data, nick, rang, stat = text:match('ID: (%d+) | (.+) | (.+): (.+) %- (.+)')
                else
                    id, data, nick, rang = text:match('ID: (%d+) | (.+) | (.+): (.+)')
                end
                color = bit.lshift(sampGetPlayerColor(id), 8)
                return {color,text}
            end
        end
    end

    if color == -8224086 then
        if #departamentlog == 25 then
            table.remove(departamentlog,1)
            table.insert(departamentlog,'['..os.date('%H:%M:%S')..']'..text)
        else
            table.insert(departamentlog,'['..os.date('%H:%M:%S')..']'..text)
        end
    end

    if color == -65366 then
        if #smslog == 25 then
            table.remove(smslog,1)
            table.insert(smslog,'['..os.date('%H:%M:%S')..']'..text)
        else
            table.insert(smslog,'['..os.date('%H:%M:%S')..']'..text)
        end
    end

end
-------
function onWindowMessage(msg, wparam, lparam)
    if msg == 0x100 or msg == 0x101 then
        if (wparam == key.VK_ESCAPE and (mws.v or sws.v or bws.v or dws.v)) and not isPauseMenuActive() then
            consumeWindowMessage(true, false)
            if msg == 0x101 then
                if sws.v then
                    if imwin == 1 or imwin == 2 then
                        imwin = 0
                    else
                        sws.v = false
                    end
                elseif bws.v then
                    if changeBind then
                        changeBind = nil
                    else
                        bws.v = false
                    end
                elseif ows.v then ows.v = false
                elseif fws.v then fws.v = false
                elseif pws.v then pws.v = false
                elseif aws.v then aws.v = false
                else
                    mws.v = false
                end
            end
        end
    end
end


function sampGetPlayerIdByNickname(nick)
    local _, myid = sampGetPlayerIdByCharHandle(playerPed)
    if tostring(nick) == sampGetPlayerNickname(myid) then return myid end
    for i = 0, 1000 do if sampIsPlayerConnected(i) and sampGetPlayerNickname(i) == tostring(nick) then return i end end
end
------------------- settings color

function getColor(ID)
	PlayerColor = sampGetPlayerColor(id)
	a, r, g, b = explode_argb(PlayerColor)
	return r/255, g/255, b/255, 1
end

function explode_argb(argb)
    local a = bit.band(bit.rshift(argb, 24), 0xFF)
    local r = bit.band(bit.rshift(argb, 16), 0xFF)
    local g = bit.band(bit.rshift(argb, 8), 0xFF)
    local b = bit.band(argb, 0xFF)
    return a, r, g, b
end

function ARGBtoRGB(color)
    local a = bit.band(bit.rshift(color, 24), 0xFF)
    local r = bit.band(bit.rshift(color, 16), 0xFF)
    local g = bit.band(bit.rshift(color, 8), 0xFF)
    local b = bit.band(color, 0xFF)
    local rgb = b
    rgb = bit.bor(rgb, bit.lshift(g, 8))
    rgb = bit.bor(rgb, bit.lshift(r, 16))
    return rgb
end

---------------------------------------------------------
function ModerBinder()
    _,MyId = sampGetPlayerIdByCharHandle(PLAYER_PED)
    MyName = sampGetPlayerNickname(MyId)
    TargetNick = sampGetPlayerNickname(tid)
    NowDate = os.date('%H:%M:%S')


    if isCharInAnyCar(PLAYER_PED) then
        CarHandle = getCarCharIsUsing(PLAYER_PED)
        IDcar = getCarModel(CarHandle)
        CarHealth = getCarHealth(CarHandle)
        CarName = CarsName[IDcar-399]

        n = 0

        for i = 0, sampGetMaxPlayerId(true) do
            bool, playerHandle = sampGetCharHandleBySampPlayerId(i)
            if bool and doesCharExist(playerHandle) then
                passCar = getCarCharIsUsing(playerHandle)
                if doesVehicleExist(passCar) and CarHandle == passCar then
                    n = n + 1
                    if n > 1 then
                        PassegerID = PassegerID..','..i
                        name = sampGetPlayerNickname(i)
                        PassegerName = PassegerName..','..name:gsub('_',' ')
                    else
                        PassegerName = sampGetPlayerNickname(i):gsub('_',' ')
                        PassegerID = i
                    end
                end
            end
        end
    end
    modBinder = {['MyId']=MyId,['MyName']=MyName,['MyNameR'] = MyName:gsub('_',' '),['TarName'] = TargetNick,
    ['TarNameR'] = TargetNick:gsub('_',' '),['TarID'] = tid,['CarName']=CarName,['CarHealth'] = CarHealth,['PassegerName'] = PassegerName,
    ['PassegerID'] = PassegerID,['KV']=kvadrat(),['MyTeg']=mainIni.config.rteg,['MyRang']=mainIni.config.rangName,
    ['NowDate'] = NowDate}
    return modBinder
end

function checkDirectory(arg)
    local directFolder = getWorkingDirectory().."\\cfg\\"..arg
    if doesDirectoryExist(directFolder) then
        print('Найден пункт конфигурации')
    else
        crfld = createDirectory(directFolder)
        if crfld then
            print('Папка аккаунта успешно создана.')
        else
            print('Во время создание папки аккаунта произошла ошибка')
        end
    end
    if true then
        directFileConfig = directFolder.."\\config.ini"
        if doesFileExist(directFileConfig) then
            print('Конфиг загружен')
        else
            file = io.open(directFileConfig,'w')
            file.close()
            if inicfg.save(newIni,directFileConfig) then print('Конфиг создан') end
            restart = true
        end
        directFileInfbar = directFolder..'\\infbar.ini'
        if doesFileExist(directFileInfbar) then
            print('Инфо-Бар загружен')
        else
            file = io.open(directFileInfbar,'w')
            file.close()
            if inicfg.save(newInf,directFileInfbar) then print('Инфо-Бар создан') end
            restart = true
        end
        directFileBinder = directFolder..'\\binder.ini'
        if doesFileExist(directFileBinder) then
            print('Биндер загружен')
        else
            file = io.open(directFileBinder,'w')
            file:close()
            if inicfg.save(newBind,directFileBinder) then print('Биндер создан') end
            restart = true
        end
        directFileOnline = directFolder..'\\online.ini'
        if doesFileExist(directFileOnline) then
            print('Счётчик онлайна загружен')
        else
            file = io.open(directFileOnline,'w')
            file:close()
            if inicfg.save(newOnl,directFileOnline) then print('Счётчик онлайна создан') end
            restart = true
        end
        directFilePost = directFolder..'\\post.ini'
        if doesFileExist(directFilePost) then
            print('Даные постов загружены')
        else
            file = io.open(directFilePost,'w')
            file:close()
            if inicfg.save(newPost,directFilePost) then print('Файл с постами создан') end
            restart = true
        end
    end
    libFolder = getWorkingDirectory()..'\\lib'
    checkPie = libFolder..'\\imgui_piemenu.lua'
    if doesFileExist(checkPie) then
        pie = require 'imgui_piemenu'
    else
        downloadUrlToFile('https://raw.githubusercontent.com/n1cho/EvolveRochester/main/cfg/imgui_piemenu.lua', checkPie, download_handler)
        restart = true
    end


    pathupd = getWorkingDirectory()..'\\update.json'
    linkupd = 'https://raw.githubusercontent.com/n1cho/EvolveRochester/main/update.json'
    downloadUrlToFile(linkupd, pathupd, download_handler)
    f = io.open(pathupd,'r')
    if f then
        info = decodeJson(f:read('*a'))
        if info.latest ~= thisScript().version then
            uws.v = true 
            if not imgui.Process then
                imgui.Process = uws.v
            end
        end
        f:close()
    end
    os.remove(pathupd)

    if restart then
        thisScript():reload()
        restart = false
    end

end

-------------------------------------
function getAmmoInClip()
    local pointer = getCharPointer(playerPed)
    local weapon = getCurrentCharWeapon(playerPed)
    local slot = getWeapontypeSlot(weapon)
    local cweapon = pointer + 0x5A0
    local current_cweapon = cweapon + slot * 0x1C
    return memory.getuint32(current_cweapon + 0x8)
end

function GetAutoBP()
    _,myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
    MyName = sampGetPlayerNickname(myid)

    dcf = getWorkingDirectory()..'\\cfg\\'..MyName..'\\config.ini'
    mainIni = inicfg.load(nil,dcf)
    if mainIni.settings.autoBP then
        local gun = {}
        if mainIni.abp.deagle then table.insert( gun, 0) end
        if mainIni.abp.shot then table.insert( gun,1 ) end
        if mainIni.abp.smg then table.insert( gun,2 ) end
        if mainIni.abp.m4 then table.insert( gun,3 ) end
        if mainIni.abp.rifle then table.insert( gun,4 ) end
        if mainIni.abp.armour then table.insert( gun,5 ) end
        if mainIni.abp.spec then table.insert( gun,6 ) end
        lua_thread.create(function()
            wait(100)
            if autoBP == #gun + 1 then -- остановка авто-бп 
                autoBP = 1
                if mainIni.abp.close then
                    sampCloseCurrentDialogWithButton(0)
                end
            elseif gun[autoBP] == 5 then
                autoBP = autoBP + 1
                wait(50)
                sampSendDialogResponse(20053, 1, 5)
                wait(500)
                sampSendDialogResponse(32700, 1, 2)
                wait(50)
                sampCloseCurrentDialogWithButton(0)
                return
            else
                sampSendDialogResponse(20053, 1, gun[autoBP])
                autoBP = autoBP + 1
            end
        end)
    end
end
--------------------------------------
function download_handler(id, status, p1, p2)
    if stop_downloading then
      stop_downloading = false
      download_id = nil
      return false -- прервать загрузку
    end
    if status == dlstatus.STATUS_DOWNLOADINGDATA then
      
    elseif status == dlstatus.STATUS_ENDDOWNLOADDATA then
      
    end
end


-------- monitoring -----------
function Search3Dtext(x, y, z, radius, patern)
    local text = ""
    local color = 0
    local posX = 0.0
    local posY = 0.0
    local posZ = 0.0
    local distance = 0.0
    local ignoreWalls = false
    local player = -1
    local vehicle = -1
    local result = false
    for id = 0, 2048 do
        if sampIs3dTextDefined(id) then
            local text2, color2, posX2, posY2, posZ2, distance2, ignoreWalls2, player2, vehicle2 = sampGet3dTextInfoById(id)
            if getDistanceBetweenCoords3d(x, y, z, posX2, posY2, posZ2) < radius then
                if string.len(patern) ~= 0 then
                    if string.match(text2, patern, 0) ~= nil then result = true end
                else
                    result = true
                end
                if result then
                    text = text2
                    color = color2
                    posX = posX2
                    posY = posY2
                    posZ = posZ2
                    distance = distance2
                    ignoreWalls = ignoreWalls2
                    player = player2
                    vehicle = vehicle2
                    radius = getDistanceBetweenCoords3d(x, y, z, posX, posY, posZ)
                end
            end
        end
    end

    return result, text, color, posX, posY, posZ, distance, ignoreWalls, player, vehicle
end

function split(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end

function cmd_getm(arg)
	local x,y,z = getCharCoordinates(PLAYER_PED)
	local result, text = Search3Dtext(x,y,z, 1000, "FBI")
	local temp = split(text, "\n")
	for k, val in pairs(temp) do
		monikQuant[k] = val
	end
	if monikQuant[6] == nil then
        sampAddChatMessage(sname..'Не удалось найти даные по мониторингу складов',-1)
	else
		monikQuantNum = {}
		for i = 1, table.getn(monikQuant) do
				number1, number2, monikQuantNum[i] = string.match(monikQuant[i],"(%d+)[^%d]+(%d+)[^%d]+(%d+)")
				monikQuantNum[i] = monikQuantNum[i]/1000
		end
        if arg == '0' then
		    sampSendChat('/r '..mainIni.config.rteg.." LSPD - "..monikQuantNum[1].." | SFPD - "..monikQuantNum[2].." | LVPD - "..monikQuantNum[3].." | SFa - "..monikQuantNum[4].." | FBI - "..monikQuantNum[6])
        elseif arg == '1' then
            sampAddChatMessage(sname.." LSPD - "..monikQuantNum[1].." | SFPD - "..monikQuantNum[2].." | LVPD - "..monikQuantNum[3].." | SFa - "..monikQuantNum[4].." | FBI - "..monikQuantNum[6],-1)
        else
            sampAddChatMessage(sname..'Введите /getm 0/1',-1)
            sampAddChatMessage(sname..'0 - В рацию | 1 - Лично вам',-1)
        end
	end
end

-------------------------------

function kvadrat(KV)
    local KV = {
			[1] = "А",
			 [2] = "Б",
			 [3] = "В",
			 [4] = "Г",
			 [5] = "Д",
			 [6] = "Ж",
			 [7] = "З",
			 [8] = "И",
			 [9] = "К",
			 [10] = "Л",
			 [11] = "М",
			 [12] = "Н",
			 [13] = "О",
			 [14] = "П",
			 [15] = "Р",
			 [16] = "С",
			 [17] = "Т",
			 [18] = "У",
			 [19] = "Ф",
			 [20] = "Х",
			 [21] = "Ц",
			 [22] = "Ч",
			 [23] = "Ш",
			 [24] = "Я",
    }
    local X, Y, Z = getCharCoordinates(playerPed)
    X = math.ceil((X + 3000) / 250)
    Y = math.ceil((Y * - 1 + 3000) / 250)
    Y = KV[Y]
		local KVX = (Y.."-"..X)
    return KVX
end

------- find kv
function cmd_findkv(arg)
    if #arg > 0 then
        if arg:match("(%A)-(%d+)") then
            local kvy, kvx = arg:match("(%A)-(%d+)")
            if getKVNumber(kvy) then
                kvx = kvx * 250 - 3125
                kvy = (getKVNumber(kvy) * 250 - 3125) * - 1
                placeWaypoint(kvx, kvy, 0)
            else
                sampAddChatMessage(sname..'Не удалось определить квадрат,возможно вы написали квадрат с маленькой буквы',-1)
            end
        else
            sampAddChatMessage(sname..'Вы неверно ввели аргумент, пример: {51964D}/findkv{FFFFFF} Д-14',-1)
        end
    else
        sampAddChatMessage(sname..'Вы неверно ввели аргумент, пример: {51964D}/findkv{FFFFFF} Д-14',-1)
    end
end

function getKVNumber(param)
    local KV = {"А","Б","В","Г","Д","Ж","З","И","К","Л","М","Н","О","П","Р","С","Т","У","Ф","Х","Ц","Ч","Ш","Я"}
    return table.getIndexID(KV, param)
  end

function table.getIndexID(object, value)
    for k, v in pairs(object) do
       if v == value then
          return k
       end
    end
    return nil
end
------ timer --------
function onScriptTerminate(script, quitGame)
    if script == thisScript() then
        showCursor(false)
    end
end

function get_clock(time)
    local timezone_offset = 86400 - os.date('%H', 0) * 3600
    if tonumber(time) >= 86400 then onDay = true else onDay = false end
    return os.date((onDay and math.floor(time / 86400)..'д ' or '')..'%H:%M:%S', time + timezone_offset)
end
---- thems ----------
function apply_custom_style(arg)
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2
    
    if arg == 0 then -- green
        style.WindowRounding = 2.0
        style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
        style.ChildWindowRounding = 2.0
        style.FrameRounding = 2.0
        style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
        style.ScrollbarSize = 13.0
        style.ScrollbarRounding = 0
        style.GrabMinSize = 8.0
        style.GrabRounding = 1.0

        colors[clr.FrameBg]                = ImVec4(0.42, 0.48, 0.16, 0.54)
        colors[clr.FrameBgHovered]         = ImVec4(0.85, 0.98, 0.26, 0.40)
        colors[clr.FrameBgActive]          = ImVec4(0.85, 0.98, 0.26, 0.67)
        colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
        colors[clr.TitleBgActive]          = ImVec4(0.42, 0.48, 0.16, 1.00)
        colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
        colors[clr.CheckMark]              = ImVec4(0.85, 0.98, 0.26, 1.00)
        colors[clr.SliderGrab]             = ImVec4(0.77, 0.88, 0.24, 1.00)
        colors[clr.SliderGrabActive]       = ImVec4(0.85, 0.98, 0.26, 1.00)
        colors[clr.Button]                 = ImVec4(0.85, 0.98, 0.26, 0.40)
        colors[clr.ButtonHovered]          = ImVec4(0.85, 0.98, 0.26, 1.00)
        colors[clr.ButtonActive]           = ImVec4(0.82, 0.98, 0.06, 1.00)
        colors[clr.Header]                 = ImVec4(0.85, 0.98, 0.26, 0.31)
        colors[clr.HeaderHovered]          = ImVec4(0.85, 0.98, 0.26, 0.80)
        colors[clr.HeaderActive]           = ImVec4(0.85, 0.98, 0.26, 1.00)
        colors[clr.Separator]              = colors[clr.Border]
        colors[clr.SeparatorHovered]       = ImVec4(0.63, 0.75, 0.10, 0.78)
        colors[clr.SeparatorActive]        = ImVec4(0.63, 0.75, 0.10, 1.00)
        colors[clr.ResizeGrip]             = ImVec4(0.85, 0.98, 0.26, 0.25)
        colors[clr.ResizeGripHovered]      = ImVec4(0.85, 0.98, 0.26, 0.67)
        colors[clr.ResizeGripActive]       = ImVec4(0.85, 0.98, 0.26, 0.95)
        colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
        colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.81, 0.35, 1.00)
        colors[clr.TextSelectedBg]         = ImVec4(0.85, 0.98, 0.26, 0.35)
        colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
        colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
        colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
        colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
        colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
        colors[clr.ComboBg]                = colors[clr.PopupBg]
        colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
        colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
        colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
        colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
        colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
        colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
        colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
        colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
        colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
        colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
        colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
        colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
    elseif arg == 1 then -- blue
        style.WindowRounding = 2.0
        style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
        style.ChildWindowRounding = 2.0
        style.FrameRounding = 2.0
        style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
        style.ScrollbarSize = 13.0
        style.ScrollbarRounding = 0
        style.GrabMinSize = 8.0
        style.GrabRounding = 1.0

        colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
        colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
        colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
        colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
        colors[clr.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
        colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
        colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
        colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
        colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
        colors[clr.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40)
        colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
        colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
        colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
        colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
        colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
        colors[clr.Separator]              = colors[clr.Border]
        colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
        colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
        colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
        colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
        colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
        colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
        colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
        colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
        colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
        colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
        colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
        colors[clr.ComboBg]                = colors[clr.PopupBg]
        colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
        colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
        colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
        colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
        colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
        colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
        colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
        colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
        colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
        colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
        colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
        colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
        colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
        colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
    elseif arg == 2 then -- orange
        style.WindowRounding = 2.0
        style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
        style.ChildWindowRounding = 2.0
        style.FrameRounding = 2.0
        style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
        style.ScrollbarSize = 13.0
        style.ScrollbarRounding = 0
        style.GrabMinSize = 8.0
        style.GrabRounding = 1.0

        colors[clr.Text] = ImVec4(0.80, 0.80, 0.83, 1.00)
        colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
        colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
        colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
        colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
        colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
        colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
        colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.TitleBg] = ImVec4(0.76, 0.31, 0.00, 1.00)
        colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75)
        colors[clr.TitleBgActive] = ImVec4(0.80, 0.33, 0.00, 1.00)
        colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
        colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00)
        colors[clr.CheckMark] = ImVec4(1.00, 0.42, 0.00, 0.53)
        colors[clr.SliderGrab] = ImVec4(1.00, 0.42, 0.00, 0.53)
        colors[clr.SliderGrabActive] = ImVec4(1.00, 0.42, 0.00, 1.00)
        colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
        colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
        colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
        colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
        colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
        colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
        colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
        colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
        colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
        colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
        colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
    elseif arg == 3 then -- purple
        style.WindowRounding = 2.0
        style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
        style.ChildWindowRounding = 2.0
        style.FrameRounding = 2.0
        style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
        style.ScrollbarSize = 13.0
        style.ScrollbarRounding = 0
        style.GrabMinSize = 8.0
        style.GrabRounding = 1.0

        colors[clr.WindowBg]              = ImVec4(0.14, 0.12, 0.16, 1.00);
        colors[clr.ChildWindowBg]         = ImVec4(0.30, 0.20, 0.39, 0.00);
        colors[clr.PopupBg]               = ImVec4(0.05, 0.05, 0.10, 0.90);
        colors[clr.Border]                = ImVec4(0.89, 0.85, 0.92, 0.30);
        colors[clr.BorderShadow]          = ImVec4(0.00, 0.00, 0.00, 0.00);
        colors[clr.FrameBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
        colors[clr.FrameBgHovered]        = ImVec4(0.41, 0.19, 0.63, 0.68);
        colors[clr.FrameBgActive]         = ImVec4(0.41, 0.19, 0.63, 1.00);
        colors[clr.TitleBg]               = ImVec4(0.41, 0.19, 0.63, 0.45);
        colors[clr.TitleBgCollapsed]      = ImVec4(0.41, 0.19, 0.63, 0.35);
        colors[clr.TitleBgActive]         = ImVec4(0.41, 0.19, 0.63, 0.78);
        colors[clr.MenuBarBg]             = ImVec4(0.30, 0.20, 0.39, 0.57);
        colors[clr.ScrollbarBg]           = ImVec4(0.30, 0.20, 0.39, 1.00);
        colors[clr.ScrollbarGrab]         = ImVec4(0.41, 0.19, 0.63, 0.31);
        colors[clr.ScrollbarGrabHovered]  = ImVec4(0.41, 0.19, 0.63, 0.78);
        colors[clr.ScrollbarGrabActive]   = ImVec4(0.41, 0.19, 0.63, 1.00);
        colors[clr.ComboBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
        colors[clr.CheckMark]             = ImVec4(0.56, 0.61, 1.00, 1.00);
        colors[clr.SliderGrab]            = ImVec4(0.41, 0.19, 0.63, 0.24);
        colors[clr.SliderGrabActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
        colors[clr.Button]                = ImVec4(0.41, 0.19, 0.63, 0.44);
        colors[clr.ButtonHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
        colors[clr.ButtonActive]          = ImVec4(0.64, 0.33, 0.94, 1.00);
        colors[clr.Header]                = ImVec4(0.41, 0.19, 0.63, 0.76);
        colors[clr.HeaderHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
        colors[clr.HeaderActive]          = ImVec4(0.41, 0.19, 0.63, 1.00);
        colors[clr.ResizeGrip]            = ImVec4(0.41, 0.19, 0.63, 0.20);
        colors[clr.ResizeGripHovered]     = ImVec4(0.41, 0.19, 0.63, 0.78);
        colors[clr.ResizeGripActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
        colors[clr.CloseButton]           = ImVec4(1.00, 1.00, 1.00, 0.75);
        colors[clr.CloseButtonHovered]    = ImVec4(0.88, 0.74, 1.00, 0.59);
        colors[clr.CloseButtonActive]     = ImVec4(0.88, 0.85, 0.92, 1.00);
        colors[clr.PlotLines]             = ImVec4(0.89, 0.85, 0.92, 0.63);
        colors[clr.PlotLinesHovered]      = ImVec4(0.41, 0.19, 0.63, 1.00);
        colors[clr.PlotHistogram]         = ImVec4(0.89, 0.85, 0.92, 0.63);
        colors[clr.PlotHistogramHovered]  = ImVec4(0.41, 0.19, 0.63, 1.00);
        colors[clr.TextSelectedBg]        = ImVec4(0.41, 0.19, 0.63, 0.43);
        colors[clr.ModalWindowDarkening]  = ImVec4(0.20, 0.20, 0.20, 0.35);
    elseif arg == 4 then -- grey
        style.WindowRounding = 2.0
        style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
        style.ChildWindowRounding = 2.0
        style.FrameRounding = 2.0
        style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
        style.ScrollbarSize = 13.0
        style.ScrollbarRounding = 0
        style.GrabMinSize = 8.0
        style.GrabRounding = 1.0

        colors[clr.Text] = ImVec4(1.00, 1.00, 1.00, 0.95)
        colors[clr.TextDisabled] = ImVec4(0.50, 0.50, 0.50, 1.00)
        colors[clr.WindowBg] = ImVec4(0.13, 0.12, 0.12, 1.00)
        colors[clr.ChildWindowBg] = ImVec4(0.13, 0.12, 0.12, 1.00)
        colors[clr.PopupBg] = ImVec4(0.05, 0.05, 0.05, 0.94)
        colors[clr.Border] = ImVec4(0.53, 0.53, 0.53, 0.46)
        colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
        colors[clr.FrameBg] = ImVec4(0.00, 0.00, 0.00, 0.85)
        colors[clr.FrameBgHovered] = ImVec4(0.22, 0.22, 0.22, 0.40)
        colors[clr.FrameBgActive] = ImVec4(0.16, 0.16, 0.16, 0.53)
        colors[clr.TitleBg] = ImVec4(0.00, 0.00, 0.00, 1.00)
        colors[clr.TitleBgActive] = ImVec4(0.00, 0.00, 0.00, 1.00)
        colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.51)
        colors[clr.MenuBarBg] = ImVec4(0.12, 0.12, 0.12, 1.00)
        colors[clr.ScrollbarBg] = ImVec4(0.02, 0.02, 0.02, 0.53)
        colors[clr.ScrollbarGrab] = ImVec4(0.31, 0.31, 0.31, 1.00)
        colors[clr.ScrollbarGrabHovered] = ImVec4(0.41, 0.41, 0.41, 1.00)
        colors[clr.ScrollbarGrabActive] = ImVec4(0.48, 0.48, 0.48, 1.00)
        colors[clr.ComboBg] = ImVec4(0.24, 0.24, 0.24, 0.99)
        colors[clr.CheckMark] = ImVec4(0.79, 0.79, 0.79, 1.00)
        colors[clr.SliderGrab] = ImVec4(0.48, 0.47, 0.47, 0.91)
        colors[clr.SliderGrabActive] = ImVec4(0.56, 0.55, 0.55, 0.62)
        colors[clr.Button] = ImVec4(0.50, 0.50, 0.50, 0.63)
        colors[clr.ButtonHovered] = ImVec4(0.67, 0.67, 0.68, 0.63)
        colors[clr.ButtonActive] = ImVec4(0.26, 0.26, 0.26, 0.63)
        colors[clr.Header] = ImVec4(0.54, 0.54, 0.54, 0.58)
        colors[clr.HeaderHovered] = ImVec4(0.64, 0.65, 0.65, 0.80)
        colors[clr.HeaderActive] = ImVec4(0.25, 0.25, 0.25, 0.80)
        colors[clr.Separator] = ImVec4(0.58, 0.58, 0.58, 0.50)
        colors[clr.SeparatorHovered] = ImVec4(0.81, 0.81, 0.81, 0.64)
        colors[clr.SeparatorActive] = ImVec4(0.81, 0.81, 0.81, 0.64)
        colors[clr.ResizeGrip] = ImVec4(0.87, 0.87, 0.87, 0.53)
        colors[clr.ResizeGripHovered] = ImVec4(0.87, 0.87, 0.87, 0.74)
        colors[clr.ResizeGripActive] = ImVec4(0.87, 0.87, 0.87, 0.74)
        colors[clr.CloseButton] = ImVec4(0.45, 0.45, 0.45, 0.50)
        colors[clr.CloseButtonHovered] = ImVec4(0.70, 0.70, 0.90, 0.60)
        colors[clr.CloseButtonActive] = ImVec4(0.70, 0.70, 0.70, 1.00)
        colors[clr.PlotLines] = ImVec4(0.68, 0.68, 0.68, 1.00)
        colors[clr.PlotLinesHovered] = ImVec4(0.68, 0.68, 0.68, 1.00)
        colors[clr.PlotHistogram] = ImVec4(0.90, 0.77, 0.33, 1.00)
        colors[clr.PlotHistogramHovered] = ImVec4(0.87, 0.55, 0.08, 1.00)
        colors[clr.TextSelectedBg] = ImVec4(0.47, 0.60, 0.76, 0.47)
        colors[clr.ModalWindowDarkening] = ImVec4(0.88, 0.88, 0.88, 0.35)
    elseif arg == 5 then -- dark
        style.WindowRounding = 2.0
        style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
        style.ChildWindowRounding = 2.0
        style.FrameRounding = 2.0
        style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
        style.ScrollbarSize = 13.0
        style.ScrollbarRounding = 0
        style.GrabMinSize = 8.0
        style.GrabRounding = 1.0

        colors[clr.Text] = ImVec4(0.80, 0.80, 0.83, 1.00)
        colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
        colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
        colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
        colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
        colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
        colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
        colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.TitleBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75)
        colors[clr.TitleBgActive] = ImVec4(0.07, 0.07, 0.09, 1.00)
        colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
        colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00)
        colors[clr.CheckMark] = ImVec4(0.80, 0.80, 0.83, 0.31)
        colors[clr.SliderGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
        colors[clr.SliderGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
        colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
        colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
        colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
        colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
        colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
        colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
        colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
        colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
        colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
        colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
    end
end