import css from "../css/app.scss";

import init_page from "./page";

window.addEventListener("load", () => {
  let root = document.getElementById("root");
  init_page(root);
});
