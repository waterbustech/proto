import * as path from 'path';

export enum EPackage {
  AUTH = 'auth',
  MEETING = 'meeting',
  CHAT = 'chat',
}

export const getProtoPath = (serviceName: EPackage) => {
  const protoPath = path.join(__dirname, '../packages');
  return path.resolve(path.join(protoPath, `${serviceName}.proto`));
};

export const getIncludeDirs = () => {
  const protoPath = path.join(__dirname, '..', 'packages');
  return path.resolve(protoPath);
};
