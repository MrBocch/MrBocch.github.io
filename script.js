const path = "static/images/";
const imageCount = 12;
const imageIndex = Math.floor(Math.random() * imageCount);
document.getElementById("image").src = `${path}${imageIndex}.jpg`;
