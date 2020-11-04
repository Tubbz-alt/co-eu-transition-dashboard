const measures = require('helpers/measures');
const sequelize = require("sequelize");
const { notify } = require('config');
const { sendMeasuresUpdatedTodayEmail } =require('services/notify');
const Op = sequelize.Op;

const getMeasuresUpdatedToday = async() => {
  const measureCategory = await measures.getCategory('Measure');
  const themeCategory = await measures.getCategory('Theme');
  const measureEntities = await measures.getMeasureEntities({
    measureCategory, 
    themeCategory,
    where: { updated_at: {
      [Op.gte]: sequelize.fn('CURDATE')
    } }
  });
  return measureEntities;
}

const getEmails = () => {
  const mailingList = notify.updatedMeasures.mailingList;
  const emails = mailingList.split(';');
  return emails;
}

const formatMeasures = (measureEntities) => {
  const formattedMeasures = measureEntities.reduce((accu, curVal)=>(
    `${accu} * ${curVal.theme} \t ${curVal.name} \t ${curVal.description} \n`
  ), '');
  return formattedMeasures.toString();
}


const notifyUpdatedMeasures = async() => {
  const measureEntities = await getMeasuresUpdatedToday();
  const emails = getEmails();
  const formattedMsrs = formatMeasures(measureEntities);
  await sendMeasuresUpdatedTodayEmail({ emails, measures: formattedMsrs });
}

module.exports = {
  notifyUpdatedMeasures
}