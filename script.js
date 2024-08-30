const path = "static/images/";
const imageCount = 36;
const imageIndex = Math.floor(Math.random() * imageCount);
document.getElementById("image").src = `${path}${imageIndex}.jpg`;
