import "./character-sheet-page.css";

const ATTRIBUTES = [
  {
    name: "Stärke",
    className: "is-staerke",
    note: "Athletik, Einschüchtern, Schwere Waffen, Schwere Rüstungen",
  },
  {
    name: "Geschick",
    className: "is-geschick",
    note: "Akrobatik, Leichte Waffen, Leichte Rüstungen",
  },
  {
    name: "Gerissenheit",
    className: "is-gerissenheit",
    note: "Diebstahl, Heimlichkeit, Schlösser knacken, Fallen",
  },
  {
    name: "Charisma",
    className: "is-charisma",
    note: "Auftreten, Provozieren, Überreden, Verführen",
  },
  {
    name: "Weisheit",
    className: "is-weisheit",
    note: "Bildung, Handwerk, Medizin, Okkultismus, Zauber",
  },
];

export default class CharacterSheetPage {
  constructor() {
    this.element = document.createElement("div");
    this.element.className = "page character-sheet-page";

    const spread = document.createElement("div");
    spread.className = "character-sheet-spread";

    spread.appendChild(this.createSheet(1));
    spread.appendChild(this.createSheet(2));

    this.element.appendChild(spread);
  }

  createSheet(index) {
    const sheet = document.createElement("section");
    sheet.className = "character-sheet";
    sheet.setAttribute("aria-label", `Charakterbogen ${index}`);

    sheet.innerHTML = `
      <div class="sheet-inner">
        <header class="sheet-header">
          <h1>Charakterbogen</h1>
        </header>

        <div class="sheet-block character-data">
          <h2>Charakterdaten</h2>
          <div class="character-data-grid">
            <div class="field-grid">
              ${this.createFieldRows(["Name", "Konzept", "Herkunft", "Motivation"])}
            </div>
            <div class="data-meta">
              <div class="damage-row">
                <span>Schaden:</span>
                <div class="damage-boxes" aria-label="5 Schadenstufen">${this.createBoxes(5, "circle")}</div>
              </div>
              <p class="hint">Kampfunfähig bei 5 Schaden.</p>
              <div class="gold-row">
                <span>Gold:</span>
                <span class="line-fill" aria-hidden="true"></span>
              </div>
            </div>
          </div>
        </div>

        <section class="sheet-lower-grid">
          <div class="sheet-block attributes-lower">
            <div class="attributes-header">
              <h2>Attribute</h2>
              <p class="section-note">Alle Attribute starten mit 10 Punkten.</p>
            </div>
            <div class="attribute-list">${this.createAttributeRows()}</div>
          </div>

          <div class="sheet-block equipped">
            <h2>Ausgerüstete Karten (5)</h2>
            <ol>${this.createNumberedLines(5)}</ol>
          </div>

          <div class="sheet-block inventory">
            <h2>Inventar (10)</h2>
            <ol>${this.createNumberedLines(10)}</ol>
          </div>
        </section>
      </div>
    `;

    return sheet;
  }

  createFieldRows(labels) {
    return labels
      .map(
        (label) => `
          <div class="field-row">
            <span class="field-label">${label}</span>
            <span class="line-fill" aria-hidden="true"></span>
          </div>
        `,
      )
      .join("");
  }

  createAttributeRows() {
    return ATTRIBUTES.map(
      (attribute) => `
        <article class="attribute-row ${attribute.className}">
          <div class="attribute-head">
            <span class="marker" aria-hidden="true"></span>
            <h3>${attribute.name}</h3>
            <span class="base">Start 10</span>
            <span class="value-line" aria-label="Aktueller Wert"></span>
          </div>
          <p>${attribute.note}</p>
        </article>
      `,
    ).join("");
  }

  createBoxes(count, shape) {
    return Array.from({ length: count }, () => `<span class="mark-box ${shape}"></span>`).join("");
  }

  createNumberedLines(count) {
    return Array.from(
      { length: count },
      (_, index) => `<li><span class="list-index">${index + 1}</span><span class="line-fill" aria-hidden="true"></span></li>`,
    ).join("");
  }

  render() {
    return this.element;
  }
}
