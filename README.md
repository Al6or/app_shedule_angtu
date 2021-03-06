<h1>Мобильное приложение разработано на кроссплатформенном фреймворке Flutter</h1>
<h2>Реферат</h2>
<p>Работа посвящена проектированию и разработки клиент-серверной информационной системе для предоставления учебного расписания Ангарского государственного технического университета.
В выпускной квалификационной работе разработан сетевой сервис и кроссплатформенное мобильное приложение с возможностью просмотра расписания занятий, расписание экзаменов, расписание консультаций, как для студентов, так и для преподавателей. </p>
<p>В информационной системе существует два способа просмотра основного расписания: календарь с пометками в виде количества пар по конкретному дню и так же список для четной и нечетной недели. В этом расписание содержится, данные о начале времени и место проведения, предмет, тип испытания, и фамилия преподавателя который проводит.</p>
<p>Так же существует возможность просмотра информации о самом учебном заведении. В эту информацию входят такие данные как список корпусов и их место расположения, способ проезда к этим зданиям. Список всех кафедр и телефонные номера для оперативной связи.
Сетевой сервис разработан на кроссплатформенном фреймворке ASP.NET Core, а мобильное приложение разработано на кроссплатформенном фреймворке Flutter. Мобильное приложение и сетевой сервис взаимодействуют между собой с помощью http запросов JSON. В качестве базы используется MySql.</p>
<h2>Разработка клиентской части</h2>
<p>Для разработки клиентской части использовался фреймворк flutter и http запросы к сетевому сервису. Обмен данными между клиентом в нашем случае это мобильное приложение и сервером (веб-сервером) используется http протоколом и его расширение https для безлопастной передачи данных. И что бы реализовать этот обмен в flutter использовался пакет http. Этот пакет содержит набор высокоуровневых функций и классов, которые упрощают использование ресурсов HTTP.
Так как приложение только для отображения данных, сделано это в основном с целью безопасности и удобства. По этим причинам были применены только GET запросы к серверу (получение ресурса). Так же существуют и другие сетевые запросы, например:</p>

 <ul>
    <li>POST (создание ресурса);</li>
    <li>PUT (обновление ресурса);</li>
    <li>DELETE (удаление ресурса).</li>
 </ul>

<p>Авторизация с сетевым сервисом осуществляется с помощью заголовков headers. В заголовках чаще всего передаются данные для авторизации и для выбора возвращаемых/передаваемых данных. На рисунке 1 представлен http запрос клиента и ответ сервера с заголовком и без заголовка. Жизненный цикл данных или диаграмма последовательностей представлена на рисунке 2. </p>
<img src="https://github.com/Al6or/app_shedule_angtu/blob/master/result/1.png">
<p>Рисунок 1 -	HTTP запрос и ответ</p>

<img src="https://github.com/Al6or/app_shedule_angtu/blob/master/result/2.png"> 
<p>Рисунок 2 -	Диаграмма последовательностей или жизненный цикл данных</p>
<p>В качестве ответа на GET запрос мобильное приложение получает JSON документ. Что бы получить данные происходит следующая цепочка событий, например для получения списка факультетов:</p>
 <ul>
    <li>Делаем сетевой запрос. В результате получим http.Response этот класс содержит данные , полученные от успешного вызова HTTP;</li>
    <li>Преобразование http.Response в объект Dart:
         <ul>    
            <li>Создается класс «факультета». Этот класс содержит данные из сетевого запроса. Он включает в себя фабричный конструктор, который создает «факультет» файл из JSON.</li>
            <li>Преобразование http ответ в «факультет». Теперь у нас есть функция, которая извлекает «факультет» из Интернета.</li>
        </ul>
    </li>    
    <li>Получить данные. Заполнение списка.</li>
    <li>Отобразить данные.</li>
 </ul>

<p>На рисунке 3 представлена структура мобильного приложения.</p>
<img src="https://github.com/Al6or/app_shedule_angtu/blob/master/result/3.png">  
<p>Рисунок 3 -	Структура мобильного приложения</p>
<ul>
    <li>В папке /appData расположены классы с http запросами, которые взаимодействуют с папкой /models;</li>
    <li>В папке /models описаны фабричные конструкторы или просто модели;</li>
    <li>В папке /list заполняются и отображаются списки кафедр, факультетов, групп, и преподавателей;</li>
    <li>Папка /screens отвечает за все экраны представлений в приложение;</li>
    <li>/Start – стартовый экран и обработка;</li>
    <li>/Tutorial – экран расписание консультаций;</li>
    <li>/Session – экран расписание сессии;</li>
    <li>/Inforation – экран с информацией о корпусах.</li>
</ul>

<h2>Результат</h2>

<table >
    <tr>
        <td><img src="https://github.com/Al6or/app_shedule_angtu/blob/master/result/1.jfif" width="300"></td>
        <td><img src="https://github.com/Al6or/app_shedule_angtu/blob/master/result/2.jfif" width="300"></td>
        <td><img src="https://github.com/Al6or/app_shedule_angtu/blob/master/result/3.jfif" width="300"></td>
    </tr>
    <tr>
        <td><img src="https://github.com/Al6or/app_shedule_angtu/blob/master/result/4.jfif" width="300"></td>
        <td><img src="https://github.com/Al6or/app_shedule_angtu/blob/master/result/5.jfif" width="300"></td>
        <td><img src="https://github.com/Al6or/app_shedule_angtu/blob/master/result/6.jpeg" width="300"></td>
    </tr>
    <tr>
        <td><img src="https://github.com/Al6or/app_shedule_angtu/blob/master/result/7.jfif" width="300"></td>
        <td><img src="https://github.com/Al6or/app_shedule_angtu/blob/master/result/8.jpeg" width="300"></td>
        <td><img src="https://github.com/Al6or/app_shedule_angtu/blob/master/result/9.jpeg" width="300"></td>
    </tr>
    <tr>
        <td><img src="https://github.com/Al6or/app_shedule_angtu/blob/master/result/10.jpeg" width="300"></td>
        <td><img src="https://github.com/Al6or/app_shedule_angtu/blob/master/result/11.jfif" width="300"></td>
        <td><img src="https://github.com/Al6or/app_shedule_angtu/blob/master/result/12.jfif" width="300"></td>
    </tr>
 </table>




