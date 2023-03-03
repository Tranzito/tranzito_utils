import flatpickr from 'flatpickr/dist/flatpickr'
import { urlForPeriod } from '../utils/period_select'

class DropdownPeriodSelector {
  init () {
    this.initDropdownPeriodSelector()
    this.enableDropdown()
  }

  enableDropdown () {
    const dropdown = document.getElementById('periodSelectDropdownButton')
    dropdown.addEventListener('click', () => {
      document.getElementById('periodSelectDropdownMenu').style.display = 'block'
      dropdown.classList.add('rotate-icon')
    })
  }

  initDropdownPeriodSelector () {
    document.getElementById('periodSelectDropdown')
      .addEventListener('click', () => {
        const selectedPeriod = document.querySelector('#periodSelectDropdown .dropdown-item.active a')
          .attributes['data-period'].value
        if (selectedPeriod === 'custom') this.initCustomPeriodSelector()
      })
    this.enablePeriodSelection()
  }

  enablePeriodSelection () {
    document.querySelectorAll('#periodSelectDropdown .dropdown-item').forEach((dropdownLink) => {
      dropdownLink.addEventListener('click', (e) => {
        if (dropdownLink.children[0].attributes['data-period'].value === 'custom') e.preventDefault()

        document.querySelector('#periodSelectDropdown .dropdown-item.active').classList.remove('active')
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
      monthSelectorType: 'static',
      onValueUpdate: (selectedDates, dateStr, instance) => this.updateCustomDatePicker(selectedDates)
    }).open()
  }

  updateCustomDatePicker (datesArr) {
    if (datesArr.length < 2) return false

    document.querySelector('#dropdownCustomSelectionForm #start_time_selector').value = datesArr[0]
    document.querySelector('#dropdownCustomSelectionForm #end_time_selector').value = datesArr[1]
    location.href = urlForPeriod('custom')
  }
}

export default DropdownPeriodSelector
