const img1 = document.getElementById("img1");
const img2 = document.getElementById("img2");
const title1 = document.getElementById("title-img1");
const title2 = document.getElementById("title-img2");

img1.addEventListener('mouseover', () => {
  title1.style.marginBottom = "40px";
});
img1.addEventListener("mouseout", () => {
    title1.style.marginBottom = "0";
})
img2.addEventListener("mouseover", () => {
    title2.style.marginBottom = "40px";
})
img2.addEventListener("mouseout", () => {
    title2.style.marginBottom = "0";
})
