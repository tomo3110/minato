<wiki-select-box>
  <select class='select-box' onchange='{ opts.changed }'>
    <option class='select-box-option'value='{ null }' selected>
      {opts.defaultLabel}
    </option>
    <option class='select-box-option' each='{ item in opts.options }' value='{ item.value }'>
      {item.label}
    </option>
  </select>

  <style scoped>
    :scope select.select-box {
      margin: 0;
      width: 100%;
      border: solid thin #ccc;
      color: #999;
    }
  </style>
</wiki-select-box>