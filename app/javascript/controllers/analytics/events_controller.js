import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    goal: String,
    value: {type: Number, default: 0}
  }

  connect() {
    window.addEventListener("turbo:load", (event) => {
      window.fathom.trackGoal(this.goalValue, this.valueValue)
    })
  }
}
