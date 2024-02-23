*** Settings ***
Documentation           Tests sur le programme de division
Library                 Process
Library                 String


*** Keywords ***

Division simple
    [Documentation]     Appelle le programme de division
    ...                 avec les argument fournis
    [Arguments]        ${numerateur}        ${diviseur}     ${resultat}
    ${calcul}          Run Process          python          division.py         ${numerateur}         ${diviseur}
    Should Be Equal    ${calcul.rc}         ${0}            msg= Le programme a planté
    Should Be Empty    ${calcul.stderr}
    Should Be Equal    ${calcul.stdout}     ${resultat}

Division euclidienne
    [Documentation]     Appelle le programme de division
    ...                 avec les argument fournis en prenant le reste en compte
    [Arguments]                   ${numerateur}         ${diviseur}            ${resultat}         ${reste}
    ${calcul}                     Run Process           python                 division.py         ${numerateur}         ${diviseur}      --reste
    Should Be Equal               ${calcul.rc}          ${0}                   msg= Le programme a planté
    Should Be Empty               ${calcul.stderr}
    ${calcul_resultat}            Get Line              ${calcul.stdout}       0
    ${calcul_reste}               Get Line              ${calcul.stdout}       1
    Should Be Equal As Integers   ${resultat}           ${calcul_resultat}
    Should Be Equal               ${reste}              ${calcul_reste}

Division en erreur
    [Arguments]            @{prog_arguments}       ${rc_attendu}        ${erreur_attendu}
    ${calcul}              Run Process             python               division.py         @{prog_arguments}
    Should Not Be Equal    ${calcul.rc}            ${0}                 msg=programme planté
    Should Not Be Equal    ${calcul.rc}            ${rc_attendu}        msg=code retour incorrect
    Should Contain         ${calcul.stderr}        ${erreur_attendu}    ignore_case=yes