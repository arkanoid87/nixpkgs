{ lib, stdenv, buildPythonPackage, fetchFromGitHub, isPy27
, pandas, shapely, fiona, pyproj
, pytestCheckHook, Rtree, fetchpatch }:

buildPythonPackage rec {
  pname = "geopandas";
  version = "0.9.0";
  disabled = isPy27;

  src = fetchFromGitHub {
    owner = "geopandas";
    repo = "geopandas";
    rev = "v${version}";
    sha256 = "18bdx90gf1170j6b9ddrhv75qkp1sq2lyk1ka5w3cix4cgmzkig7";
  };

  propagatedBuildInputs = [
    pandas
    shapely
    fiona
    pyproj
  ];

  doCheck = !stdenv.isDarwin;
  checkInputs = [ pytestCheckHook Rtree ];
  disabledTests = [ "web" ];
  pytestFlagsArray = [ "geopandas" ];

  meta = with lib; {
    description = "Python geospatial data analysis framework";
    homepage = "https://geopandas.org";
    license = licenses.bsd3;
    maintainers = with maintainers; [ knedlsepp ];
  };
}
