
&НаКлиенте
Процедура ТипПриИзменении(Элемент)
	Если Строка(Объект.Тип)="Физическое лицо" Тогда
		Элементы.КПП.Доступность = Ложь;
		//Объект.КПП = ""; - можно удалить данные
	Иначе
		Элементы.КПП.Доступность=Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВставитьНаименование(Команда)
	Если Не ЗапретНаРасшифровкуНаименования Тогда
	Объект.ПолноеНаименование = Расшифровка(Объект.Наименование);

	КонецЕсли;
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция Расшифровка(Наименование)
	
	Перем Замена, КраткоеНазвание, НазваниеФирмы;
	
	КраткоеНазвание = Строка(Наименование);
	Замена = Лев(КраткоеНазвание,3);
	Если Замена = "ООО" Тогда
		НазваниеФирмы = "Общество с ограниченной ответственностью" +Строка(Сред(КраткоеНазвание,4));
	ИначеЕсли Замена = "АО " Тогда
		НазваниеФирмы = "Акционерное общество " +Строка(Сред(КраткоеНазвание,4));		
	ИначеЕсли Замена ="ИП " Тогда
		НазваниеФирмы = "Индивидуальный предприниматель " +Строка(Сред(КраткоеНазвание,4));	
	КонецЕсли;
Возврат НазваниеФирмы;

КонецФункции

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Если Строка(Объект.Тип)="Физическое лицо" Тогда
		Элементы.КПП.Доступность = Ложь;
		Иначе
		Элементы.КПП.Доступность=Истина;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	ЗапретНаРасшифровкуНаименования = ЗначениеЗаполнено(Объект.ПолноеНаименование) И Объект.ПолноеНаименование <> Расшифровка(Объект.Наименование);
КонецПроцедуры

&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)
	
	Если Не ЗапретНаРасшифровкуНаименования Тогда
	Объект.ПолноеНаименование = Расшифровка(Объект.Наименование);

	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ИННПриИзменении(Элемент)
	РезультатПроверки=РаботаСИНН.ИННВерен(Объект.ИНН,Объект.Тип);
	Если НЕ РезультатПроверки.Верен Тогда
    	Сообщить(РезультатПроверки.ТекстОшибки);
	Элементы.ИНН.ЦветТекста =WebЦвета.Красный;
	Иначе
	Элементы.ИНН.ЦветТекста = Новый Цвет;

	КонецЕсли;
КонецПроцедуры 

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
    РезультатПроверки=РаботаСИНН.ИННВерен(Объект.ИНН,Объект.Тип);
	Если НЕ РезультатПроверки.Верен Тогда
	Сообщить(РезультатПроверки.ТекстОшибки);
	Элементы.ИНН.ЦветТекста =WebЦвета.Красный;
	Отказ = Истина;
Иначе
	Элементы.ИНН.ЦветТекста = Новый Цвет;
КонецЕсли;

	ЭтоЮрЛицо = Объект.Тип= ПредопределенноеЗначение("Перечисление.ЮридическоеФизическоеЛицо.ЮридическоеЛицо");
	ЭтоФизЛицо = Объект.Тип = ПредопределенноеЗначение("Перечисление.ЮридическоеФизическоеЛицо.ФизическоеЛицо");
	ДлинаКПП =СтрДлина(Объект.КПП);		
	Если ЭтоЮрЛицо И ДлинаКПП<>9 Тогда
		Сообщить ("КПП юридического лица должно содержать 9 цифр!");
		Элементы.КПП.ЦветТекста =WebЦвета.Красный;
		Отказ=Истина;
	ИначеЕсли ЭтоФизЛицо И ДлинаКПП<>0 Тогда
		Сообщить ("У физического лица не должно быть заполнено КПП. ");
		Элементы.КПП.ЦветТекста =WebЦвета.Красный;
		Отказ=Истина;
	Иначе
		Элементы.КПП.ЦветТекста = Новый Цвет;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура КПППриИзменении(Элемент)
	ЭтоЮрЛицо = Объект.Тип= ПредопределенноеЗначение("Перечисление.ЮридическоеФизическоеЛицо.ЮридическоеЛицо");
	ЭтоФизЛицо = Объект.Тип = ПредопределенноеЗначение("Перечисление.ЮридическоеФизическоеЛицо.ФизическоеЛицо");
	ДлинаКПП =СтрДлина(Объект.КПП);		
	Если ЭтоЮрЛицо И ДлинаКПП<>9 Тогда
		Сообщить ("КПП юридического лица должно содержать 9 цифр!");
		Элементы.КПП.ЦветТекста =WebЦвета.Красный;
	ИначеЕсли ЭтоФизЛицо И ДлинаКПП<>0 Тогда
		Сообщить ("У физического лица не должно быть заполнено КПП. ");
		Элементы.КПП.ЦветТекста =WebЦвета.Красный;
	Иначе
		Элементы.КПП.ЦветТекста = Новый Цвет;
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура КонтактныеЛицаНаСервере()
		ВыборкаКонтактныхЛиц = Справочники.КонтактныеЛица.Выбрать(,Объект.Ссылка);
	Пока ВыборкаКонтактныхЛиц.Следующий() Цикл
		ИмяКонтактногоЛица =ВыборкаКонтактныхЛиц.Наименование;
		ДолжностьКонтактногоЛица=ВыборкаКонтактныхЛиц.Должность;
		ТелефонКонтактногоЛица=ВыборкаКонтактныхЛиц.Телефон;
		Сообщить(СтрШаблон("%1 - %2, телефон %3",ИмяКонтактногоЛица, ДолжностьКонтактногоЛица, ТелефонКонтактногоЛица));
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура КонтактныеЛица(Команда)
	КонтактныеЛицаНаСервере();
КонецПроцедуры



