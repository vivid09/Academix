/**
 * 
 */

 // 현재 날짜와 시간 표시
function updateDateTime() {
  var now = new Date();
  var formattedDate = now.getFullYear() + '-' +
                      ('0' + (now.getMonth() + 1)).slice(-2) + '-' +
                      ('0' + now.getDate()).slice(-2) + ' (' +
                      ['일', '월', '화', '수', '목', '금', '토'][now.getDay()] + ')';
  var formattedTime = ('0' + now.getHours()).slice(-2) + ':' +
                      ('0' + now.getMinutes()).slice(-2) + ':' +
                      ('0' + now.getSeconds()).slice(-2);
  document.getElementById('currentDateTime').textContent = formattedDate;
  document.getElementById('currentTime').textContent = formattedTime;
}
setInterval(updateDateTime, 1000);

const tempSection = document.querySelector('.temperature');
const placeSection = document.querySelector('.place');
const descSection = document.querySelector('.description');
const weathericonSection = document.querySelector('.WeatherIcon');

$(document).ready(() => {
	navigator.geolocation.getCurrentPosition(success, fail);
})

const API_KEY = '381b085873ccdd54271f597d592ee5f9';

const success = (position) => {
	const latitude = position.coords.latitude;
	const longitude = position.coords.longitude;
	
	getWeather(latitude, longitude);
}
const fail = () => {
	alert("좌표를 받아올 수 없음");
}

const getWeather = (lat, lon) => {
	fetch(
	  'https://api.openweathermap.org/data/2.5/weather?lat=' + lat + '&lon=' + lon + '&appid=' + API_KEY + '&units=metric&lang=kr'
	)
	.then((response) => response.json())
	.then(resData => {
		console.log(resData);
		tempSection.innerText =  Math.floor(resData.main.temp) + '°C';
		placeSection.innerText = resData.name;
		descSection.innerText = resData.weather[0].description;
		weathericonSection.setAttribute('src', 'http://openweathermap.org/img/wn/' + resData.weather[0].icon + '@2x.png');
	})
	.catch(error => {
		console.error('There was a problem with the fetch operation:', error);
	});
}