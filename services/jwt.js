const jwt = require('jsonwebtoken');
const config = require('config');

const saveData = (req, res, data = {}) => {
  const existingData = restoreData(req);
  const dataToSave = Object.assign({}, existingData, data);
  const token = jwt.sign(dataToSave, config.cookie.secret);
  res.cookie('jwt', token);
};

const token = req => {
  if (req && req.cookies) {
    return req.cookies['jwt'];
  }
  return null;
};

const restoreData = req => {
  if (req && req.cookies['jwt']) {
    return jwt.verify(req.cookies['jwt'], config.cookie.secret);
  } else {
    return {};
  }
};

module.exports = {
  saveData,
  restoreData,
  token
};