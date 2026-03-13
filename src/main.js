import "./style.css";
import Card from "./card.js";
import Page from "./page.js";

async function loadCSV() {
  const response = await fetch("/src/assets/PSI RP - Hintergründe.tsv");
  const text = await response.text();

  const rows = text
    .trim()
    .split("\n")
    .map((row) => row.split("\t"));

  return rows;
}

async function main() {
  const data = await loadCSV();
  data.shift();

  document.body.innerHTML = "";

  for (let i = 0; i < data.length; i += 10) {
    const pageData = data.slice(i, i + 10);
    const page = new Page();

    pageData.forEach((entry) => {
      const card = new Card(entry);
      page.addCard(card.render());
    });

    document.body.appendChild(page.render());
  }
}

main();
