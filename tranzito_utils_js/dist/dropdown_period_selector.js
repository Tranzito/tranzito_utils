import flatpickr from "flatpickr/dist/flatpickr";

class DropdownPeriodSelector {
  init() {
    const showDateButton = document.querySelector(
      "#periodSelectDropdown .dropdown-item #showDateField"
    );
    showDateButton.addEventListener("click", () => {
      const customDatePickerField = document.getElementById(
        "customPeriodSelectDatePicker"
      );
      const customDatePicker = flatpickr(customDatePickerField, {
        mode: "range",
        dateFormat: "Y-m-d",
        disable: [(date) => date >= new Date()],
        onValueUpdate: (selectedDates, dateStr, instance) => this.updateCustomDatePicker(selectedDates)
      });
      customDatePicker.open();
    });
  }

  urlForPeriod(selectedPeriod = null) {
    return (
      window.location.origin +
      location.pathname +
      "?" +
      this.urlParamsWithNewPeriod(selectedPeriod).toString()
    );
  }

  urlParamsWithoutPeriod() {
    const urlParams = new URLSearchParams(window.location.search);
    urlParams.delete("period");
    urlParams.delete("timezone");
    urlParams.delete("start_time");
    urlParams.delete("end_time");
    urlParams.append("timezone", window.localTimezone);
    return urlParams;
  }

  urlParamsWithNewPeriod(selectedPeriod = null) {
    // If it's null, empty, undefined or anything other than string
    if (typeof selectedPeriod !== "string") {
      // If not passed the period, Figure it out, defaulting to all
      selectedPeriod =
        document.querySelector("#timeSelectionBtnGroup .btn.active").attributes[
          "data-period"
        ]?.value || "all";
    }

    const urlParams = this.urlParamsWithoutPeriod();
    urlParams.append("period", selectedPeriod);

    if (selectedPeriod === "custom") {
      urlParams.append(
        "start_time",
        document.getElementById("start_time_selector").value
      );
      urlParams.append(
        "end_time",
        document.getElementById("end_time_selector").value
      );
    }
    return urlParams;
  }

  updateCustomDatePicker(datesArr) {
    if (datesArr.length < 2) return false;

    document.querySelector(
      "#dropdownCustomSelectionForm #start_time_selector"
    ).value = datesArr[0];
    document.querySelector(
      "#dropdownCustomSelectionForm #end_time_selector"
    ).value = datesArr[1];
    location.href = this.urlForPeriod("custom");
  }
}

export default DropdownPeriodSelector;
