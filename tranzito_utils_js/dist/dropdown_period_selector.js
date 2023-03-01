import flatpickr from 'flatpickr/dist/flatpickr'
import { urlForPeriod } from '../utils/period_select'

class DropdownPeriodSelector {
  init () {
    this.initDropdownPeriodSelector()
    this.initCustomPeriodSelector()
  }

  initDropdownPeriodSelector () {
    document.getElementById('periodSelectDropdown')
      .addEventListener('click', () => {
        const selectedPeriod = document.querySelector('#periodSelectDropdown .dropdown-item.active')
          .children[0].attributes['data-period'].value
        if (selectedPeriod === 'custom') {
          const startDate = document.querySelector('#dropdownCustomSelectionForm #start_time_selector').value
          const endDate = document.querySelector('#dropdownCustomSelectionForm #end_time_selector').value
          this.initDatePicker(startDate, endDate)
        }
      })
    this.enablePeriodSelection()
  }

  enablePeriodSelection () {
    document.querySelectorAll('#periodSelectDropdown .dropdown-item').forEach((dropdwonLink) => {
      dropdwonLink.addEventListener('click', (e) => {
        document.querySelector('#periodSelectDropdown .dropdown-item.active').classList.remove('active')
        e.currentTarget.classList.add('active')
      })
    })
  }

  initDatePicker (startDate, endDate) {
    startDate = startDate || new Date()
    endDate = endDate || new Date()

    flatpickr('#customPeriodSelectDatePicker', {
      mode: 'range',
      defaultDate: [startDate, endDate],
      arrowTop: false,
      prevArrow: '<<',
      nextArrow: '>>',
      dateFormat: 'Y-m-d',
      disable: [(date) => date >= new Date()],
      onValueUpdate: (selectedDates, dateStr, instance) => this.updateCustomDatePicker(selectedDates)
    }).open()
  }

  initCustomPeriodSelector () {
    document.querySelector('#periodSelectDropdown .dropdown-item #showDateField')
      .addEventListener('click', () => {
        this.initDatePicker()
      })
  }

  updateCustomDatePicker (datesArr) {
    if (datesArr.length < 2) return false

    document.querySelector('#dropdownCustomSelectionForm #start_time_selector').value = datesArr[0]
    document.querySelector('#dropdownCustomSelectionForm #end_time_selector').value = datesArr[1]
    location.href = urlForPeriod('custom')
  }
}

export default DropdownPeriodSelector
