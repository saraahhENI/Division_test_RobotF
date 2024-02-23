*** Settings ***
Library             Process
Documentation       Contient les tests du programme hello.py


*** Test Cases ***
Test d'appel du programme
    ${res}              Run Process             python             hello.py
    #Log                 ${res.stdout}
    #Log                 ${res.rc}
    #${zero}             Convert To Integer      0
    #Should Be Equal     ${res.rc}               ${zero}                  msg=Le programme a planté
    #Should Be Equal As Integers       ${res.rc}          0       msg=Le programme a planté

    Should Be Equal      ${res.rc}               ${0}               msg=Le programme a planté
    Should Be Empty      ${res.stderr}
    Should Be Equal      ${res.stdout}           hello world