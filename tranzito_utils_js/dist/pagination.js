export class Pagination {
  initPerPageSelect () {
    document.querySelector('#per_page_select')?.addEventListener('change', function (e) {
      const urlParams = new URLSearchParams(window.location.search)
      urlParams.delete('per_page')
      urlParams.append('per_page', document.querySelector('#per_page_select').value)
      window.location = `${location.pathname}?${urlParams.toString()}`
    })
  }

  init () {
    this.initPerPageSelect()
  }
}

export default Pagination
