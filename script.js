// 初始化地圖
const map = L.map('map').setView([51.505, -0.09], 13);

// 添加 OpenStreetMap 圖層
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
}).addTo(map);

// 添加一個自訂圖標
const marker = L.marker([51.5, -0.09]).addTo(map);

// 使用 Geolocation API 獲取當前位置
navigator.geolocation.getCurrentPosition((position) => {
    const lat = position.coords.latitude;
    const lng = position.coords.longitude;

    // 更新地圖視圖
    map.setView([lat, lng], 17);

    // 添加標記到當前位置
    L.marker([lat, lng]).addTo(map)
        .bindPopup('你現在的位置')
        .openPopup();
}, (error) => {
    console.error('無法獲取位置', error);
});
