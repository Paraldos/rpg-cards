export default class Card {
  constructor(data) {
    this.data = data;

    console.log(data);
  }

  render() {
    const card = document.createElement("div");
    card.className = "card";

    card.innerHTML = `
      <h3>${this.data[0] ?? ""}</h3>
      <p>${this.data[1] ?? ""}</p>
	  <h4>Passive</h4>
	  <p>${this.data[2]}</p>
	  <h4>Aktive</h4>
		<p>${this.data[3]}</p>
	  `;

    return card;
  }
}
