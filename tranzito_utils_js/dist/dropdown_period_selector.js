import flatpickr from 'flatpickr/dist/flatpickr'
import { urlForPeriod } from '../utils/period_select'

class DropdownPeriodSelector {
  init () {
    this.initDropdownPeriodSelector()
    this.enableDropdown()
  }

  enableDropdown () {
    const dropdown = document.getElementById('periodSelectDropdownButton')
    const menu = document.getElementById('periodSelectDropdownMenu')

    dropdown.addEventListener('click', () => {
      const isHidden = menu.style.display === 'none' || !menu.style.display
      menu.style.display = isHidden ? 'block' : 'none'
      dropdown.classList.toggle('rotate-icon', isHidden)
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
    const menu = document.getElementById('periodSelectDropdownMenu')
    document.querySelectorAll('#periodSelectDropdown .dropdown-item').forEach((dropdownLink) => {
      dropdownLink.addEventListener('click', (e) => {
        if (dropdownLink.children[0].attributes['data-period'].value === 'custom') e.preventDefault()

        document.querySelector('#periodSelectDropdown .dropdown-item.active').classList.remove('active')
        e.currentTarget.classList.add('active')
        menu.style.display = 'none'
        document.getElementById('periodSelectDropdownButton').classList.remove('rotate-icon')
      })
    })
  }

  initCustomPeriodSelector () {
    const startDate = document.querySelector('#dropdownCustomSelectionForm #start_time_selector').value
    const endDate = document.querySelector('#dropdownCustomSelectionForm #end_time_selector').value

    flatpickr('#customPeriodSelectDatePicker', {
      mode: 'range',
      appendTo: document.getElementById('dropdownCustomSelectionForm'),
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
