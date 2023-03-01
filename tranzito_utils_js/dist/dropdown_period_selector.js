import flatpickr from 'flatpickr/dist/flatpickr'
import { urlForPeriod } from '../utils/period_select'

class DropdownPeriodSelector {
  init () {
    this.initDropdownPeriodSelector()
  }

  initDropdownPeriodSelector () {
    document.getElementById('periodSelectDropdown')
      .addEventListener('click', () => {
        const selectedPeriod = document.querySelector('#periodSelectDropdown .dropdown-item a.active')
          .attributes['data-period'].value
        if (selectedPeriod === 'custom') this.initCustomPeriodSelector()
      })
    this.enablePeriodSelection()
  }

  enablePeriodSelection () {
    document.querySelectorAll('#periodSelectDropdown .dropdown-item a').forEach((dropdwonLink) => {
      dropdwonLink.addEventListener('click', (e) => {
        if(dropdwonLink.attributes['data-period'].value == 'custom') e.preventDefault()

        document.querySelector('#periodSelectDropdown .dropdown-item a.active').classList.remove('active')
        e.currentTarget.classList.add('active')
      })
    })
  }

  initCustomPeriodSelector () {
    const startDate = document.querySelector('#dropdownCustomSelectionForm #start_time_selector').value
    const endDate = document.querySelector('#dropdownCustomSelectionForm #end_time_selector').value

    flatpickr('#customPeriodSelectDatePicker', {
      mode: 'range',
      defaultDate: [startDate, endDate],
      dateFormat: 'Y-m-d',
      disable: [(date) => date >= new Date()],
      onValueUpdate: (selectedDates, dateStr, instance) => this.updateCustomDatePicker(selectedDates),
    }).open()
    document.getElementsByClassName('flatpickr-calendar')[0].classList.remove('arrowTop')
  }

  updateCustomDatePicker (datesArr) {
    if (datesArr.length < 2) return false

    document.querySelector('#dropdownCustomSelectionForm #start_time_selector').value = datesArr[0]
    document.querySelector('#dropdownCustomSelectionForm #end_time_selector').value = datesArr[1]
    location.href = urlForPeriod('custom')
  }
}

export default DropdownPeriodSelector
