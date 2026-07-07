function initDataTable(selector, data, columns) {
  new DataTable(selector, {
    data: data,
    columns: columns,
    pageLength: 25,
    order: [[0, "asc"]],
    autoWidth: false,
    initComplete: function () {
      this.api().table().node().style.tableLayout = "fixed";
    },
    layout: {
      topStart: [
        {
          buttons: [
            {
              extend: 'csvHtml5',
              text: 'Download CSV'
            }
          ]
        },

      ],
      topEnd: "search",
      bottomStart: "info",
      bottomEnd: "paging"
    }
  });
}

function parseCsvFromUrl(csvUrl) {
  return new Promise((resolve, reject) => {
    Papa.parse(csvUrl, {
      download: true,
      header: true,
      dynamicTyping: false,
      skipEmptyLines: true,
      complete: function (results) {
        if (results.errors.length) {
          reject(results.errors);
          return;
        }

        resolve(results.data);
      },
      error: function (err) {
        reject(err);
      }
    });
  });
}

function transformTpmasRows(lookupRows) {
  return lookupRows.map(row => {
    const subtypeValue = row.tpma_subtype;
    const toValue = row.active_to;

    return {
      Code: row.tpma_code,
      Name: row.tpma_name,
      Subtype: subtypeValue === "NA" ? "-" : subtypeValue,
      Mechanism: row.tpma_mechanism,
      From: row.active_from,
      To: toValue === "NA" ? "-" : toValue
    };
  });
}

function applyTableCellWrapping(columns) {
  return columns.map(column => ({
    ...column,
    createdCell: function (td) {
      td.style.whiteSpace = "normal";
      td.style.overflowWrap = "anywhere";
      td.style.wordBreak = "break-word";
    }
  }));
}

async function loadTpmasTable(
  selector,
  {
    // TODO: update path when merged to main in TPMAs repo
    lookupCsvUrl = "https://raw.githubusercontent.com/The-Strategy-Unit/TPMAs/refs/heads/10-lookup-update/reference/tpma-lookup.csv"
  } = {}
) {
  try {
    const lookupRows = await parseCsvFromUrl(lookupCsvUrl);

    const data = transformTpmasRows(lookupRows);
    const columns = [
      { title: "Code", data: "Code", width: "95px" },
      { title: "Name", data: "Name" },
      { title: "Subtype", data: "Subtype" },
      { title: "Mechanism", data: "Mechanism" },
      { title: "From", data: "From", width: "65px" },
      { title: "To", data: "To", width: "65px" }
    ];

    initDataTable(selector, data, applyTableCellWrapping(columns));
  } catch (err) {
    console.error("Failed to load TPMA table", err);
    document.querySelector(selector).insertAdjacentHTML(
      "afterend",
      "<p><em>Sorry, the table failed to load.</em></p>"
    );
  }
}
