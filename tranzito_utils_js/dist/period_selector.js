import { urlForPeriod } from '../utils/period_select'
class PeriodSelector {
  init () {
    this.autoSubmit = !(
      document.getElementById('timeSelectionBtnGroup').attributes['data-nosubmit']?.value === 'true'
    )
    this.enablePeriodSelection()
  }

  enableCustomSelection () {
    // Show the custom selection inputs
    document
      .querySelectorAll('#timeSelectionBtnGroup .period-select-standard')
      .forEach((btn) => {
        btn.classList.remove('active')
      })
    document.getElementById('periodSelectCustom').classList.add('active')
    document.getElementById('timeSelectionBtnGroup').classList.add('custom-period-selected')
    document.getElementById('timeSelectionCustom').classList.add('in')
    document.getElementById('timeSelectionCustom').style.display = 'flex'
  }

  disableCustomSelection () {
    document.getElementById('timeSelectionCustom').classList.remove('in')
    document.getElementById('timeSelectionCustom').style.display = 'none'
    document.getElementById('timeSelectionBtnGroup').classList.remove('custom-period-selected')
  }

  enablePeriodSelection () {
    const self = this
    document.querySelectorAll('#timeSelectionBtnGroup .btn').forEach((btn) => {
      btn.addEventListener('click', (e) => {
        let eventTarget = e.currentTarget
        let selectedPeriod = eventTarget.attributes['data-period']?.value
        // Sometimes, the target isn't the button, it's something inside the button. In that case, find the correct period
        if (typeof selectedPeriod === 'undefined') {
          // If we can't figure out what the target was, return false, so the user clicks again
          if (!eventTarget.parentElement?.classList.contains('btn')) return

          eventTarget = eventTarget.parentElement?.classList.contains('btn')
          selectedPeriod = eventTarget.attributes['data-period']?.value
        }
        // If it's a link (e.g. "past hour") just follow the link!
        if (eventTarget.attributes.href?.value) {
          return true
        }

        if (selectedPeriod === 'custom') {
          return self.enableCustomSelection()
        } else {
          // Not really necessary, but makes it a little slicker
          self.disableCustomSelection()
        }
        document.querySelector('#timeSelectionBtnGroup .period-select-standard.active').classList.remove('active')
        eventTarget.classList.add('active')
        if (self.autoSubmit) {
          return (location.href = self.urlForPeriod(selectedPeriod))
        } else {
          // log.debug(self.urlForPeriod(selectedPeriod));
          return true
        }
      })
    })

    // If not autosubmitting, this needs to be managed separately
    if (self.autoSubmit) {
      document
        .getElementById('timeSelectionCustom')
        .addEventListener('submit', (e) => {
          location.href = urlForPeriod('custom')
          return false
        })
    }
  }
}

export default PeriodSelector
