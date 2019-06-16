ITEM.name = "Таблетки 'Пси-блокада'"
ITEM.category = "Медицина"
ITEM.desc = "Наркотический препарат, блокирующий лавинообразные нервные импульсы. Интересен побочный эффект: после приёма препарата наблюдается кратковременное исчезновение каких-либо эмоций. В Зоне используется для противодействия аномальным полям повышенной пси-активности; за её пределами применения не нашёл. Обладает продолжительным действием."
ITEM.model = "models/stalker/item/medical/psy_pills.mdl"
ITEM.price = 550
ITEM.width = 1
ITEM.height = 1
ITEM.functions.use = {
    name = "Использовать",
    icon = "icon16/add.png",
    onRun = function(item)
       local client = item.player
       client:setNetVar("psy", client:getNetVar("psy", 0) - 25)
       client:ConCommand("say "..client:getNetVar("psy", 0))
       return true
    end,
    onCanRun = function(item)
        return !IsValid(item.entity)
    end
}
 
ITEM.permit = "misc"