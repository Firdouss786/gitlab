import { Controller } from 'stimulus';

export default class extends Controller {

  static targets = ['daysPassed'];
  obj_refresh = null;

  initialize() {
    this.calculateDaysPassed();
    this.obj_refresh = setInterval( () => this.refresh_page(), 15000 );
  }

  calculateDaysPassed() {
    this.daysPassedTargets.forEach(function (element) {
      let days = this.diffDays(element.dataset.info);
      element.querySelector('#daysPassed').innerHTML = days;
      element.querySelector('#statusColor').classList.add(this.getStatusColor(days));
    }.bind(this));
  }

  diffDays(timestamp) {
    let current_utc_date = moment();
    let record_utc_date = moment(timestamp);
    return current_utc_date.diff(record_utc_date, 'days');
  }

  getStatusColor(days) {
    if (days < 2) {
      return "bg-thales-green";
    }
    else if (days === 2) {
      return "bg-thales-yellow";
    }
    else if (days > 2) {
      return "bg-thales-red";
    }
  }

  refresh_page() {
    let tableDiv = document.getElementById("table-container");
    let url = location.href + (location.search ? '&' : '?') + 'refresh=true';

    fetch(url)
      .then(response => response.text())
      .then(html => {
        tableDiv.innerHTML = html;
        this.calculateDaysPassed();
      })
  }

  disconnect() {
    clearInterval(this.obj_refresh);
  }

}
