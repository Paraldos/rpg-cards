import "./style.css";
import Card from "./card.js";
import Page from "./page.js";
import CharacterSheetPage from "./character-sheet-page.js";

import ausruestungUrl from "./assets/PSI RP - Ausruestung.tsv?url";
import hintergruendeUrl from "./assets/PSI RP - Hintergründe.tsv?url";
import manoeverUrl from "./assets/PSI RP - Manoever.tsv?url";

async function loadTSV(path) {
  const response = await fetch(path);

  if (!response.ok) {
    throw new Error(`Fehler beim Laden von ${path}: ${response.status}`);
  }

  const text = await response.text();

  return text
    .trim()
    .split("\n")
    .map((row) => row.replace(/\r$/, "").split("\t"));
}

async function loadTSVFiles() {
  const files = [ausruestungUrl, hintergruendeUrl, manoeverUrl];

  const allData = await Promise.all(files.map(loadTSV));

  return allData
    .flatMap((rows) => rows.slice(1))
    .filter((row) => row.some((cell) => cell && cell.trim() !== ""));
}

async function main() {
  const data = await loadTSVFiles();

  console.log("Gesamt:", data.length, "Einträge");

  document.body.innerHTML = "";

  const characterSheetPage = new CharacterSheetPage();
  document.body.appendChild(characterSheetPage.render());

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

main().catch(console.error);
