export default () =>  {

  const dropDownOptions = document.getElementById('dropDownOptions');
  const type = document.getElementsByName('type');

  function changeHandler() {
    if (this.value === 'group') {
      dropDownOptions.style.display = 'block'
    } else {
      dropDownOptions.style.display = 'none' 
    }
  }
  
  Array.prototype.forEach.call(type, function(type) {
    type.addEventListener('change', changeHandler);
  });


  var addOption = document.getElementById("add-option");
  var dropdownOption = document.getElementById("drop-down-option");

  addOption.onclick = function(e) { return myHandler(e); };

  function myHandler() {

    var option = document.createElement('input');
    option.setAttribute('name', 'config[options][]');
    option.setAttribute('type', 'text');
    option.classList.add('govuk-input');
    option.classList.add('options');
    dropdownOption.parentNode.insertBefore(option, dropdownOption.nextSibling);
    
    return false;
  }

}