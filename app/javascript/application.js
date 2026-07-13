// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"

document.addEventListener("turbo:load", () =>{
  const input = document.getElementById("room-image-input");
  const preview = document.getElementById("image-preview");

  if (!input) return;

  input.addEventListener("change",(event) => {
    const file = event.target.files[0];
    
    if (file){
      preview.src = URL.createObjectURL(file);
      preview.style.display = "block";
    }
  });
});