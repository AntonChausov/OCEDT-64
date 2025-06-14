
&НаКлиенте
Процедура ПоказыватьПомеченныхНаУдаление(Команда)
	ПоказыватьПомеченныхНаУдаление = Не ПоказыватьПомеченныхНаУдаление;
  	Элементы.ФормаПоказыватьПомеченныхНаУдаление.Пометка = ПоказыватьПомеченныхНаУдаление;
  
  	ПолеПометкаУдаления = Новый ПолеКомпоновкиДанных("ПометкаУдаления");
  	НайденныйЭлементОтбора = Неопределено;
  	ЭлементыОтбора = Список.КомпоновщикНастроек.Настройки.Отбор.Элементы;
  	Для Каждого ЭлементОтбора Из ЭлементыОтбора Цикл
  		Если ЭлементОтбора.ЛевоеЗначение = ПолеПометкаУдаления Тогда
  			НайденныйЭлементОтбора = ЭлементОтбора;
  			Прервать;
  		КонецЕсли;
  	КонецЦикла;
  
  	Если НайденныйЭлементОтбора = Неопределено Тогда
  		НайденныйЭлементОтбора = ЭлементыОтбора.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
  		НайденныйЭлементОтбора.ЛевоеЗначение = ПолеПометкаУдаления;
  	КонецЕсли;
  
  	НайденныйЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
    НайденныйЭлементОтбора.ПравоеЗначение = Ложь;
	НайденныйЭлементОтбора.Использование = Не ПоказыватьПомеченныхНаУдаление;
КонецПроцедуры

