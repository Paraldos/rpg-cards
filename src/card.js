import "./card.css";

export default class Card {
  constructor(data) {
    this.data = data;
  }

  render() {
    const card = document.createElement("div");
    card.className = "card";

    const passive =
      this.data[2] || this.data[3]
        ? `
        <div class="card-passive">
          <h4>Passive</h4>
          ${this.data[2] ? `<p>${this.data[2]}</p>` : ""}
          ${this.data[3] ? `<p>${this.data[3]}</p>` : ""}
        </div>
      `
        : "";

    const active = this.data[4]
      ? `
        <div class="card-active">
          <h4>Aktive</h4>
          <p>${this.data[4]}</p>
        </div>
      `
      : "";

    card.innerHTML = `
      <h3>${this.data[0] ?? ""}</h3>
      <p>Type: ${this.data[1] ?? ""}</p>

      ${passive}
      ${active}
    `;

    return card;
  }
}
