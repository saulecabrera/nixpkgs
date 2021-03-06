{ lib
, buildPythonPackage
, fetchPypi
, pythonOlder
, pytest
, blis
, catalogue
, cymem
, jsonschema
, murmurhash
, numpy
, pathlib
, plac
, preshed
, requests
, setuptools
, srsly
, thinc
, wasabi
}:

buildPythonPackage rec {
  pname = "spacy";
  version = "2.3.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0nri437dyapiq5gx8lbmjdfvqw2cnw3di13kp44rzr17bm5yh2jv";
  };

  propagatedBuildInputs = [
   blis
   catalogue
   cymem
   jsonschema
   murmurhash
   numpy
   plac
   preshed
   requests
   setuptools
   srsly
   thinc
   wasabi
  ] ++ lib.optional (pythonOlder "3.4") pathlib;

  checkInputs = [
    pytest
  ];

  doCheck = false;
  # checkPhase = ''
  #   ${python.interpreter} -m pytest spacy/tests --vectors --models --slow
  # '';

  postPatch = ''
    substituteInPlace setup.cfg --replace "thinc==7.4.1" "thinc>=7.4.1,<8"
  '';

  meta = with lib; {
    description = "Industrial-strength Natural Language Processing (NLP) with Python and Cython";
    homepage = "https://github.com/explosion/spaCy";
    license = licenses.mit;
    maintainers = with maintainers; [ danieldk sdll ];
  };
}
