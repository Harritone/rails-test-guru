document.addEventListener('turbolinks:load', function () {
  const titleTableHeader = document.querySelector('.sort-by-title');

  // console.log(arrowUp);

  if (titleTableHeader) {
    titleTableHeader.addEventListener('click', sortRowsByTitle);
  }
});

function sortRowsByTitle() {
  const table = document.querySelector('.table');
  const rows = table.querySelectorAll('tr');
  let sortedRows = [];

  for (let i = 1; i < rows.length; i++) {
    sortedRows.push(rows[i]);
  }

  const arrowUp = this.querySelector('.fa-caret-up');
  const arrowDown = this.querySelector('.fa-caret-down');

  if (arrowUp.classList.contains('d-none')) {
    sortedRows.sort(compareRowsAsc);
    arrowUp.classList.remove('d-none');
    arrowDown.classList.add('d-none');
  } else {
    sortedRows.sort(compareRowsDesc);
    arrowDown.classList.remove('d-none');
    arrowUp.classList.add('d-none');
  }

  const sortedTable = document.createElement('table');
  sortedTable.classList.add('table', 'table-striped');
  sortedTable.appendChild(rows[0]);

  for (row of sortedRows) {
    sortedTable.appendChild(row);
  }

  table.parentNode.replaceChild(sortedTable, table);
}

const compareRowsAsc = (row1, row2) => {
  const quizTitle1 = row1.querySelector('td').textContent;
  const quizTitle2 = row2.querySelector('td').textContent;
  if (quizTitle1 < quizTitle2) return -1;
  if (quizTitle1 > quizTitle2) return 1;
  return 0;
};

const compareRowsDesc = (row1, row2) => {
  const quizTitle1 = row1.querySelector('td').textContent;
  const quizTitle2 = row2.querySelector('td').textContent;
  if (quizTitle1 < quizTitle2) return 1;
  if (quizTitle1 > quizTitle2) return -1;
  return 0;
};
