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
		<h1>Charakterbogen</h1>

        <div class="sheet-block character-data">
          <h2>Charakterdaten</h2>
		  ${this.createCharacterDataRow(["Name", "Konzept", "Motivation"])}
        </div>

        <section class="sheet-block damage-box">
          <h2>Schaden & Gold</h2>
          <div class="damage-row">
            <span class="field-label">Schaden:</span>
            <div class="damage-boxes">${this.createBoxes(5, "circle")}</div>
            <span class="field-label">Gold:</span>
            <span class="field-line"></span>
          </div>
        </section>

        <section class="sheet-lower-grid">
          <div class="sheet-block attributes-lower">
			<h2>Attribute</h2>
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
    `;

    return sheet;
  }

  createCharacterDataRow(labels) {
    return labels
      .map(
        (label) => `
          <div class="character-data-row">
            <span class="field-label">${label}</span>
            <span class="field-line" aria-hidden="true"></span>
          </div>
        `,
      )
      .join("");
  }

  createAttributeRows() {
    return ATTRIBUTES.map(
      (attribute) => `
        <article class="attribute-row ${attribute.className}">
        	<div class="attribute-text">
				<span class="marker" aria-hidden="true"></span>
				<h3>${attribute.name}</h3>
				<p>${attribute.note}</p>
			</div>
			<span class="attribute-value" aria-label="Aktueller Wert"></span>
        </article>
      `,
    ).join("");
  }

  createBoxes(count, shape) {
    return Array.from(
      { length: count },
      () => `<span class="mark-box ${shape}"></span>`,
    ).join("");
  }

  createNumberedLines(count) {
    return Array.from(
      { length: count },
      (_, index) =>
        `<li><span class="list-index">${index + 1}</span><span class="line-fill" aria-hidden="true"></span></li>`,
    ).join("");
  }

  render() {
    return this.element;
  }
}
