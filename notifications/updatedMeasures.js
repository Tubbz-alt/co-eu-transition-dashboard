const measures = require('helpers/measures');
const sequelize = require("sequelize");
const { notify } = require('config');
const notifyServices =require('services/notify');
const cache = require('services/cache');
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
  const emails = mailingList.split(';').map(email => (email.trim()));
  return emails;
}

const formatMeasures = (measureEntities) => {
  const formattedMeasures = measureEntities.reduce((accu, curVal)=>(
    `${accu} * ${curVal.theme}  ${curVal.name}  ${curVal.description}`
  ), '');
  return formattedMeasures.toString();
}


const notifyUpdatedMeasures = async() => {
  cache.clear();
  const measureEntities = await getMeasuresUpdatedToday();
  const emails = getEmails();
  const formattedMeasures = formatMeasures(measureEntities);
  await notifyServices.sendMeasuresUpdatedTodayEmail({ emails, measures: formattedMeasures });
}

module.exports = {
  notifyUpdatedMeasures
}