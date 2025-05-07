//realizare tabele
set serveroutput on size unlimited;


create table Panou (
  id_user number(5) primary key,
  nume varchar2(100) not null,
  prenume varchar2(250) not null,
  email varchar2(300) not null,
  id_echipa number(2),
  rol varchar2(40) check (rol in ('Participant', 'Organizator')),
  foreign key (id_echipa) references Echipe(id_echipa)
);

create table Hackathon (
  id_hackathon number(5) primary key,
  nume_hackathon varchar2(150) not null,
  durata_ore number(3) not null,
  status varchar2(30) check (status in ('Activ', 'Incheiat'))
);


create table Echipe (
  id_echipa number(5) primary key,
  nume_echipa varchar2(100) not null,
  id_capitan number(5),
  punctaj_echipa number
);

create table Echipe_Hackathon (
  id_echipa number(5),
  id_hackathon number(5),
  primary key (id_echipa, id_hackathon),
  foreign key (id_echipa) references Echipe(id_echipa),
  foreign key (id_hackathon) references Hackathon(id_hackathon)
);


create table Proiecte (
  id_proiect number(5) primary key,
  id_echipa number(5),
  id_hackathon number(5),
  nume_proiect varchar2(150) not null,
  descriere varchar2(1000),
  foreign key (id_echipa) references Echipe(id_echipa),
  foreign key (id_hackathon) references Hackathon(id_hackathon)
);


create table Juriu(
  id_jurat number(3) primary key,
  nume varchar2(100) not null,
  prenume varchar2(250) not null,
  companie_jurat varchar2(150)
);


create table Sponsori(
  id_sponsor number(3) primary key,
  nume varchar2(150) not null,
  valoare_sponsorizare number(9) 
);


create table Mentori(
  id_mentor number(3) primary key,
  nume varchar2(100) not null,
  prenume varchar2(250) not null,
  email varchar2(300) unique not null
); 


create table Premii(
  id_premiu number(3) primary key,
  id_hackathon number(3),
  nume_premiu varchar2(200) not null,
  valoare number(5),
  foreign key(id_hackathon) references Hackathon(id_hackathon)
);
create table Sesiuni_Mentoring (
  id_sesiune number(5) primary key,
  id_mentor number(5),
  id_echipa number(5),
  tema_sesiune varchar2(200),
  data_sesiune date,
  durata_minute number(3),
  feedback_echipa clob,
  foreign key (id_mentor) references Mentori(id_mentor),
  foreign key (id_echipa) references Echipe(id_echipa)
);

create table Activitati (
  id_activitate number(5) primary key,
  id_hackathon number(5),
  titlu varchar2(150) not null,
  tip_activitate varchar2(50) check (tip_activitate in ('Workshop', 'Prezentare', 'Panel', 'Networking')),
  data_start timestamp,
  durata_minute number(3),
  locatie varchar2(100),
  foreign key (id_hackathon) references Hackathon(id_hackathon)
);

create table Evaluari (
  id_evaluare number(5) primary key,
  id_proiect number(5),
  id_jurat number(5),
  punctaj number(3) check (punctaj between 0 and 100),
  comentariu varchar2(500),
  data_evaluare date default sysdate,
  foreign key (id_proiect) references Proiecte(id_proiect),
  foreign key (id_jurat) references Juriu(id_jurat)
);


// Seminar1
//set1 comenzi
begin

  insert into Hackathon (id_hackathon, nume_hackathon, durata_ore, status) values (1, 'Hackathon 2025', 24, 'Activ');
  insert into Hackathon (id_hackathon, nume_hackathon, durata_ore, status) values (2, 'Tech Challenge', 48, 'Activ');
  insert into Hackathon (id_hackathon, nume_hackathon, durata_ore, status) values (3, 'CodeFest', 36, 'Activ');
  insert into Hackathon (id_hackathon, nume_hackathon, durata_ore, status) values (4, 'AI Hackathon', 24, 'Activ');
  insert into Hackathon (id_hackathon, nume_hackathon, durata_ore, status) values (5, 'Data Science Marathon', 48, 'Activ');
  insert into Hackathon (id_hackathon, nume_hackathon, durata_ore, status) values (6, 'Cybersecurity Sprint', 30, 'Activ');


  insert into Echipe (id_echipa, nume_echipa, id_capitan, punctaj_echipa) values (1, 'CSIE', 1, 85);
  insert into Echipe (id_echipa, nume_echipa, id_capitan, punctaj_echipa) values (2, 'Cod Rosu', 2, 90);
  insert into Echipe (id_echipa, nume_echipa, id_capitan, punctaj_echipa) values (3, 'Byte Masters', 3, 95);
  insert into Echipe (id_echipa, nume_echipa, id_capitan, punctaj_echipa) values (4, 'Cyber Squad', 4, 88);
  insert into Echipe (id_echipa, nume_echipa, id_capitan, punctaj_echipa) values (5, 'AI Wizards', 5, 80);
  insert into Echipe (id_echipa, nume_echipa, id_capitan, punctaj_echipa) values (6, 'Future Innovators', 6, 87);


  insert into Juriu (id_jurat, nume, prenume, companie_jurat) values (1, 'Ionescu', 'Maria', 'Tech Corp');
  insert into Juriu (id_jurat, nume, prenume, companie_jurat) values (2, 'Dumitru', 'Alexandru', 'InnovateX');
  insert into Juriu (id_jurat, nume, prenume, companie_jurat) values (3, 'Enache', 'Cristina', 'SoftVision');
  insert into Juriu (id_jurat, nume, prenume, companie_jurat) values (4, 'Radu', 'Mihai', 'Google Romania');
  insert into Juriu (id_jurat, nume, prenume, companie_jurat) values (5, 'Tudor', 'Andreea', 'Microsoft');

 
  insert into Sponsori (id_sponsor, nume, valoare_sponsorizare) values (1, 'MegaTech', 10000);
  insert into Sponsori (id_sponsor, nume, valoare_sponsorizare) values (2, 'SoftVision', 15000);
  insert into Sponsori (id_sponsor, nume, valoare_sponsorizare) values (3, 'InnovateX', 20000);
  insert into Sponsori (id_sponsor, nume, valoare_sponsorizare) values (4, 'Google', 50000);
  insert into Sponsori (id_sponsor, nume, valoare_sponsorizare) values (5, 'Microsoft', 30000);

  
  insert into Mentori (id_mentor, nume, prenume, email) values (1, 'Georgescu', 'Andrei', 'andrei.georgescu@gmail.com');
  insert into Mentori (id_mentor, nume, prenume, email) values (2, 'Popescu', 'Ioana', 'ioana.popescu@yahoo.com');
  insert into Mentori (id_mentor, nume, prenume, email) values (3, 'Iliescu', 'Marius', 'marius.iliescu@email.com');
  insert into Mentori (id_mentor, nume, prenume, email) values (4, 'Stan', 'Daniela', 'daniela.stan@yahoo.com');
  insert into Mentori (id_mentor, nume, prenume, email) values (5, 'Dinu', 'Adrian', 'adrian.dinu@gmail.com');


  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (1, 'Popescu', 'Ion', 'ion.popescu@yahoo.com', 'Organizator', null);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (2, 'Ionescu', 'Maria', 'maria.ionescu@yahoo.com', 'Participant', 1);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (3, 'Georgescu', 'Andrei', 'andrei.georgescu@gmail.com', 'Organizator', null);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (4, 'Dumitrescu', 'Ana', 'ana.dumitrescu@hotmail.com', 'Participant', 2);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (5, 'Vasilescu', 'Mihai', 'mihai.vasilescu@yahoo.com', 'Participant', 3);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (6, 'Stan', 'Elena', 'elena.stan@email.com', 'Participant', 3);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (7, 'Radulescu', 'Cristian', 'cristian.radulescu@gmail.com', 'Participant', 4);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (8, 'Iliescu', 'Daniel', 'daniel.iliescu@yahoo.com', 'Participant', 4);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (9, 'Popa', 'Alexandra', 'alexandra.popa@gmail.com', 'Participant', 5);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (10, 'Munteanu', 'Bogdan', 'bogdan.munteanu@yahoo.com', 'Participant', 5);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (11, 'Pandele', 'Lucia', 'lucia.pandele@gmail.com', 'Participant', 6);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (12, 'Toma', 'Adrian', 'adrian.toma@yahoo.com', 'Participant', 6);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (13, 'Constantin', 'Vasile', 'vasile.constantin@yahoo.com', 'Participant', 1);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (14, 'Ilinca', 'Ioana', 'ioana.ilinca@gmail.com', 'Participant', 2);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (15, 'Nistor', 'Mihail', 'mihail.nistor@yahoo.com', 'Participant', 3);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (16, 'Chiriac', 'Iulian', 'iulian.chiriac@hotmail.com', 'Participant', 4);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (17, 'Petcu', 'Andreea', 'andreea.petcu@outlook.com', 'Organizator', null);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (18, 'Dobre', 'Rares', 'rares.dobre@yahoo.com', 'Organizator', null);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (19, 'Lazar', 'Cristina', 'cristina.lazar@gmail.com', 'Participant', 5);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (20, 'Barbu', 'Sorin', 'sorin.barbu@email.com', 'Participant', 6);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (21, 'Enache', 'Roxana', 'roxana.enache@hotmail.com', 'Participant', 1);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (22, 'Marin', 'Florin', 'florin.marin@yahoo.com', 'Participant', 2);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (23, 'Radu', 'Gabriel', 'gabriel.radu@gmail.com', 'Participant', 3);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (24, 'Simion', 'Teodora', 'teodora.simion@outlook.com', 'Participant', 4);
  insert into Panou (id_user, nume, prenume, email, rol, id_echipa) values (25, 'Neagu', 'Paul', 'paul.neagu@yahoo.com', 'Participant', 5);

 
  insert into Echipe_Hackathon (id_echipa, id_hackathon) values (1, 1);
  insert into Echipe_Hackathon (id_echipa, id_hackathon) values (2, 2);
  insert into Echipe_Hackathon (id_echipa, id_hackathon) values (3, 3);
  insert into Echipe_Hackathon (id_echipa, id_hackathon) values (4, 4);
  insert into Echipe_Hackathon (id_echipa, id_hackathon) values (5, 5);
  insert into Echipe_Hackathon (id_echipa, id_hackathon) values (6, 6);


  insert into Proiecte (id_proiect, id_echipa, id_hackathon, nume_proiect, descriere) values (1, 1, 1, 'Smart Assistant', 'Un AI care automatizeaza taskurile');
  insert into Proiecte (id_proiect, id_echipa, id_hackathon, nume_proiect, descriere) values (2, 2, 2, 'Health Tracker', 'Aplicatie pentru monitorizarea sanatatii');
  insert into Proiecte (id_proiect, id_echipa, id_hackathon, nume_proiect, descriere) values (3, 3, 3, 'EcoDrive', 'Sistem inteligent pentru condus ecologic');
  insert into Proiecte (id_proiect, id_echipa, id_hackathon, nume_proiect, descriere) values (4, 4, 4, 'RoboTrader', 'Bot pentru tranzactii automate pe bursa');
  insert into Proiecte (id_proiect, id_echipa, id_hackathon, nume_proiect, descriere) values (5, 5, 5, 'EduTech', 'Platforma pentru educatie online.');


  insert into Premii (id_premiu, id_hackathon, nume_premiu, valoare) values (1, 1, 'Cel mai bun proiect', 5000);
  insert into Premii (id_premiu, id_hackathon, nume_premiu, valoare) values (2, 2, 'Cea mai inovatoare idee', 7000);
  insert into Premii (id_premiu, id_hackathon, nume_premiu, valoare) values (3, 3, 'Cel mai bun UI/UX', 3000);
  insert into Premii (id_premiu, id_hackathon, nume_premiu, valoare) values (4, 4, 'Cel mai bine documentat proiect', 4000);
  insert into Premii (id_premiu, id_hackathon, nume_premiu, valoare) values (5, 5, 'Cel mai promitator startup', 6000);

  insert into Sesiuni_Mentoring (id_sesiune, id_mentor, id_echipa, tema_sesiune, data_sesiune, durata_minute, feedback_echipa)   values (1, 1, 1, 'Cum sa imbunatatim interfata aplicatiei', to_date('2025-05-10', 'yyyy-mm-dd'), 60, 'Foarte utila sesiune, am primit sfaturi excelente.');
  insert into Sesiuni_Mentoring (id_sesiune, id_mentor, id_echipa, tema_sesiune, data_sesiune, durata_minute, feedback_echipa)   values (2, 2, 2, 'Tehnici de imbunatatire a performantei aplicatiei', to_date('2025-05-12', 'yyyy-mm-dd'), 75, 'Am primit feedback constructiv privind optimizarea codului.');
  insert into Sesiuni_Mentoring (id_sesiune, id_mentor, id_echipa, tema_sesiune, data_sesiune, durata_minute, feedback_echipa)   values (3, 3, 3, 'Dezvoltarea unui plan de marketing pentru proiect', to_date('2025-05-15', 'yyyy-mm-dd'), 90, 'Sesiune interesanta, am invatat multe despre cum sa promovam proiectul.');

  insert into Activitati (id_activitate, id_hackathon, titlu, tip_activitate, data_start, durata_minute, locatie) values (1, 1, 'Workshop despre AI', 'Workshop', to_timestamp('2025-05-11 10:00:00', 'yyyy-mm-dd hh24:mi:ss'), 120, 'Sala 1');
  insert into Activitati (id_activitate, id_hackathon, titlu, tip_activitate, data_start, durata_minute, locatie) values (2, 2, 'Prezentare despre startup-uri', 'Prezentare', to_timestamp('2025-05-13 14:00:00', 'yyyy-mm-dd hh24:mi:ss'), 90, 'Sala 2');
  insert into Activitati (id_activitate, id_hackathon, titlu, tip_activitate, data_start, durata_minute, locatie) values (3, 3, 'Panel despre inovare in tehnologie', 'Panel', to_timestamp('2025-05-14 16:00:00', 'yyyy-mm-dd hh24:mi:ss'), 60, 'Sala 3');

  insert into Evaluari (id_evaluare, id_proiect, id_jurat, punctaj, comentariu) values (1, 1, 1, 90, 'Proiect foarte bine realizat, dar ar putea fi imbunatatit la nivel de UX.');
  insert into Evaluari (id_evaluare, id_proiect, id_jurat, punctaj, comentariu) values (2, 2, 2, 85, 'Ideea este buna, dar mai sunt cateva detalii tehnice de optimizat.');
  insert into Evaluari (id_evaluare, id_proiect, id_jurat, punctaj, comentariu) values (3, 3, 3, 95, 'Un proiect excelent, cu un design foarte intuitiv si functionalitati utile.');

  commit;
  dbms_output.put_line('Toate datele au fost inserate cu succes!');
end;
/
//Seminar 1

// Stergerea unui sponsor dupa ID
set serveroutput on;
declare 
v_id_sponsor Sponsori.id_sponsor%type:=5;
begin 
delete from Sponsori 
where id_sponsor=v_id_sponsor;
dbms_output.put_line('Sponsorul cu id ul '|| v_id_sponsor||' a fost sters ');
end;
/

// Adaugare nou mentor 
set serveroutput on;
declare 
v_id_mentor Mentori.id_mentor%type:=10;
v_nume_mentor Mentori.nume%type:='Vladislav';
v_prenume_mentor Mentori.prenume%type:='Darius';
v_email_mentor Mentori.email%type:='vladislav22@yahoo.com';
begin 
insert into Mentori(id_mentor,nume,prenume,email) values (v_id_mentor,v_nume_mentor,v_prenume_mentor,v_email_mentor);
dbms_output.put_line('Mentorul cu Id ul '||v_id_mentor|| ' a fost inserat cu succes ');
end;
/

//Afisare detalii hackathon + formatare nume_hackathon
set serveroutput on;
declare 
v_id_hackathon Hackathon.id_hackathon%type:=1;
v_nume1_hackathon Hackathon.nume_hackathon%type;
v_nume2_hackathon Hackathon.nume_hackathon%type;
begin 
select nume_hackathon,initcap(nume_hackathon) into 
v_nume1_hackathon,v_nume2_hackathon 
from Hackathon 
where id_hackathon=v_id_hackathon;
dbms_output.put_line(' Numele 1 '||v_nume1_hackathon||' Numele2 '|| v_nume2_hackathon);
end;
/

//Modificare statut Hackathon 

declare 
v_id_hackathon_updt Hackathon.id_hackathon%type:=2;
v_status_nou Hackathon.status%type:='Incheiat';
begin 
update Hackathon 
set status=v_status_nou
where id_hackathon=v_id_hackathon_updt
and status='Activ';
dbms_output.put_line('Status ul hackathon ului a fost schimbat cu succes');
end;
/


//Seminar 2

//Selectie variabila de substitutie

accept id_sponsor_selectie prompt 'Introduceti Id pentru a vedea valoarea sponsorizarii: '
declare 
v_id_sponsor Sponsori.id_sponsor%type :=&id_sponsor_selectie;
v_nume_sponsor Sponsori.nume%type;
v_valoare_sponsorizare Sponsori.valoare_sponsorizare%type;
begin 

select nume,valoare_sponsorizare into v_nume_sponsor,v_valoare_sponsorizare from Sponsori 
where id_sponsor=&id_sponsor_selectie;
dbms_output.put_line(' Sponsorul '||v_nume_sponsor||' v_valoare_sponsorizare '|| v_valoare_sponsorizare);
end;
/

//Introducere activitate noua 
set serveroutput on;
declare
    v_activitate Activitati%rowtype;
begin
   
    v_activitate.id_activitate := &id_activitate;
    v_activitate.id_hackathon := &id_hackathon;
    v_activitate.titlu := '&titlu_activitate';
    v_activitate.tip_activitate := '&tip_activitate';
    v_activitate.data_start := TO_DATE('&data_start', 'DD-MON-YYYY HH24:MI'); 
    v_activitate.durata_minute := &durata_minute;
    v_activitate.locatie := '&locatie_activitate';


    insert into Activitati (id_activitate, id_hackathon, titlu, tip_activitate, data_start, durata_minute, locatie)
    values (v_activitate.id_activitate, v_activitate.id_hackathon, v_activitate.titlu, v_activitate.tip_activitate, v_activitate.data_start, v_activitate.durata_minute, v_activitate.locatie);

    dbms_output.put_line('Activitatea cu ID ' || v_activitate.id_activitate || ' a fost adaugata cu succes.');

end;
/


//Stergere sesiune de mentoring
accept numar_luna_de_sters prompt 'Introduceti numarul lunii (1-12) pe care doriti sa o stergeti: ' 

declare 
    v_luna_sters number;
begin 
    v_luna_sters := &numar_luna_de_sters;
    delete from Sesiuni_Mentoring where extract(month from data_sesiune) = v_luna_sters;
end;
/

// Schimba numele companiei pentru un membro specific al juriului 
set serveroutput on;
accept id_membru_juriu prompt 'Introduceti Id-ul membrului din juriu: ' number
accept noua_companie prompt 'Introduceti noul nume al companiei: '

declare 
    v_id_membru number;
    v_noua_companie varchar2(100);
begin 
    v_id_membru := &id_membru_juriu;
    v_noua_companie := '&noua_companie';

    update Juriu 
    set companie_jurat = v_noua_companie 
    where id_jurat = v_id_membru;

    dbms_output.put_line('Compania pentru membrul juriului cu ID-ul ' || v_id_membru || ' a fost actualizata cu succes la "' || v_noua_companie || '".');
end;
/



//Seminar 3

//Clasificare premii dupa valoare_sponsorizare 
accept id_premiu_clasament prompt 'Introduceti ID-ul premiului: '

declare 
    v_id_premiu number;
    v_valoare_sponsorizare Premii.valoare%type;
    v_mesaj_sponsorizare varchar2(100);
begin 
    v_id_premiu := &id_premiu_clasament;

    select valoare_sponsorizare into v_valoare_sponsorizare 
    from Sponsori
    where id_sponsor = v_id_premiu;

    case 
        when v_valoare_sponsorizare <=5000 then
            v_mesaj_sponsorizare := 'Basic';
        when v_valoare_sponsorizare between 5000 and 15000 then
            v_mesaj_sponsorizare := 'Standard';
        when v_valoare_sponsorizare between 15001 and 30000 then
            v_mesaj_sponsorizare := 'Premium';
        when v_valoare_sponsorizare > 30000 then
            v_mesaj_sponsorizare := 'Elite';
    end case;

    dbms_output.put_line('Premiul cu ID-ul ' || v_id_premiu || ' are o sponsorizare de ' || NVL(TO_CHAR(v_valoare_sponsorizare), 'NULL') || '. Mesaj: ' || v_mesaj_sponsorizare);
end;
/

// Afisare activitati cu forloop
declare 
    v_id_start number := 1;
    v_id_end number := 3; 
    v_denumire_activitate activitati.titlu%type;
    v_tip_activitate activitati.tip_activitate%type;
    v_data_start activitati.data_start%type;
    v_durata_minute activitati.durata_minute%type;
    v_locatie activitati.locatie%type;

begin 
    for i in v_id_start..v_id_end loop
        begin 
            select titlu, tip_activitate, data_start, durata_minute, locatie 
            into v_denumire_activitate, v_tip_activitate, v_data_start, v_durata_minute, v_locatie
            from activitati 
            where id_activitate = i;

            dbms_output.put_line(
                'id: ' || i ||
                ', denumire: ' || v_denumire_activitate ||
                ', tip: ' || v_tip_activitate ||
                ', data/ora: ' || to_char(v_data_start, 'dd-mon-yyyy hh24:mi') || 
                ', durata: ' || v_durata_minute || ' min' ||
                ', locatie: ' || v_locatie
            );
        end; 
    end loop;
end;
/


// Stergem toti organizatorii din tabelul Panou
set serveroutput on;
declare
    v_id_organizator number;
    v_count_delete number := 0;
    v_max_organizatori number;
begin
    select count(*) into v_max_organizatori
    from panou
    where rol = 'Organizator';

    if v_max_organizatori = 0 then
        dbms_output.put_line('nu exista organizatori de sters.');
        return;
    end if;
    loop
        exit when v_count_delete = v_max_organizatori;
        select id_user
        into v_id_organizator
        from panou
        where rol = 'Organizator'
        fetch first 1 row only;
        if v_id_organizator is not null then
            delete from panou where id_user = v_id_organizator;
            v_count_delete := v_count_delete + 1;
            dbms_output.put_line('sters organizatorul cu id-ul: ' || v_id_organizator);
        end if;
    end loop;

    dbms_output.put_line('s-au sters ' || v_count_delete || ' organizatori.');
end;
/
rollback;

//Punctajele impare din evaluari

begin 
    for r_evaluare in (select id_evaluare, punctaj, comentariu from evaluari) loop 
        if mod(r_evaluare.punctaj,2) = 1 then 
            dbms_output.put_line('evaluare id: ' || r_evaluare.id_evaluare || ' punctaj: ' || r_evaluare.punctaj);
        end if;
    end loop;
end;
/

//Seminar 4

//Nume Prenume si Mail pt ultimii 4 participanti
set serveroutput on;
declare 
    cursor c_participanti is select id_user, nume, prenume, email from panou order by id_user desc;
    r_participant c_participanti%rowtype;
    v_limita_participanti number := 4;
    v_count number := 0;
begin 
    open c_participanti;
    loop 
        fetch c_participanti into r_participant;
        exit when v_count >= v_limita_participanti or c_participanti%notfound;
        
        dbms_output.put_line('id: ' || r_participant.id_user || ', nume: ' || r_participant.nume || ', prenume: ' || r_participant.prenume || ', email: ' || r_participant.email);
        
        v_count := v_count + 1;
    end loop;
    close c_participanti;

    if not c_participanti%isopen then
        dbms_output.put_line('cursorul a fost inchis corect.');
    end if;
end;
/


//Selecteaza prima activitate ordonata dupa data_de_start
set serveroutput on;
declare 
    cursor c_activitati is select id_activitate, titlu, data_start, durata_minute 
    from activitati 
    order by data_start asc;

    v_id_activitate activitati.id_activitate%type;
    v_titlu activitati.titlu%type;
    v_data_start activitati.data_start%type;
    v_durata_minute activitati.durata_minute%type;

begin 
    open c_activitati;
    fetch c_activitati into v_id_activitate, v_titlu, v_data_start, v_durata_minute;
    
    if v_id_activitate is not null then
        dbms_output.put_line('--- activitatea care incepe prima ---');
        dbms_output.put_line('  id: ' || v_id_activitate);
        dbms_output.put_line('  titlu: ' || v_titlu);
        dbms_output.put_line('  data start: ' || to_char(v_data_start, 'yyyy-mm-dd hh24:mi:ss'));
        dbms_output.put_line('  durata (minute): ' || v_durata_minute);
    else
        dbms_output.put_line('nu s-au gasit activitati in tabela.');
    end if;
    
    close c_activitati;
end;
/

// Cursor explicit pentru a selecta evaluarile cu un punctaj mai mic decat un prag specificat
set serveroutput on;
declare 
cursor 
c_eval_proiecte(p_prag number) is 
select e.id_evaluare,e.id_proiect,e.id_jurat,e.punctaj,p.nume_proiect from evaluari e,proiecte p
where e.id_proiect=p.id_proiect(+)
and e.punctaj<p_prag;
r_eval c_eval_proiecte%rowtype;
v_prag number:=60;
begin 
open c_eval_proiecte(v_prag);
loop 
fetch c_eval_proiecte into r_eval;
exit when c_eval_proiecte%notfound;
if length(r_eval.nume_proiect)<10 then 
dbms_output.put_line('Evaluare ID: ' || r_eval.id_evaluare || ', Proiect: ' || r_eval.nume_proiect ||', Jurat: ' || r_eval.id_jurat ||', Punctaj: ' || r_eval.punctaj);
 end if;
 end loop;
 close c_eval_proiecte;
 end;
 /
 
 
 // Cursor explicit pentru a selecta sesiunile cu cele mai multe echipe
set serveroutput on;
declare
  cursor c_top_sesiuni is
    select id_sesiune, count(id_echipa) as nr_sesiuni
    from sesiuni_mentoring
    group by id_sesiune
    order by nr_sesiuni desc;

  v_id_sesiune sesiuni_mentoring.id_sesiune%type;
  v_nr_sesiuni number;
  v_max_sesiuni number := 3;

begin
  open c_top_sesiuni;
  for i in 1..v_max_sesiuni loop
    fetch c_top_sesiuni into v_id_sesiune, v_nr_sesiuni;
    exit when c_top_sesiuni%notfound;
    dbms_output.put_line('id sesiune: ' || v_id_sesiune || ', numar echipe: ' || v_nr_sesiuni);
  end loop;
  close c_top_sesiuni;
end;
/


//Seminar 5

// Tabela Mentori + Sesiuni_Mentoring Join 
set serveroutput on;

declare
    cursor c_mentori is
    select m.id_mentor, m.nume, m.prenume, m.email, 
           s.id_sesiune, s.tema_sesiune, s.data_sesiune
    from mentori m, sesiuni_mentoring s
    where m.id_mentor = s.id_mentor(+);
    
begin
  for mentor_rec IN c_mentori loop
    dbms_output.put_line('Mentor: ' || mentor_rec.nume || ' ' || mentor_rec.prenume || '  Email: ' || mentor_rec.email);

    if mentor_rec.id_sesiune is not null then 
      dbms_output.put_line('  Sesiune: ' || mentor_rec.id_sesiune || '   Tema: ' || mentor_rec.tema_sesiune || '  Data: ' || mentor_rec.data_sesiune);
    else
      dbms_output.put_line('  Nu sunt sesiuni.');
   end if;
    
    dbms_output.put_line('===============');
  end loop;
end;
/


// Facem modificare folosind cursor pe tabela update
set serveroutput on;
declare
  cursor c_sponsori is
    select id_sponsor, valoare_sponsorizare
    from sponsori
    where valoare_sponsorizare < 20000
    for update of valoare_sponsorizare;
  v_noua_valoare sponsori.valoare_sponsorizare%type;

begin 

  for sponsor_rec in c_sponsori loop

    v_noua_valoare := sponsor_rec.valoare_sponsorizare + 5000;

    update sponsori
    set valoare_sponsorizare = v_noua_valoare
    where current of c_sponsori;
    
    dbms_output.put_line('Sponsorul ID ' || sponsor_rec.id_sponsor || 
                         ' a primit bonus de 5000. Noua valoare: ' || v_noua_valoare);
  end loop;
  
end;
/


// Functie pentru penalizare punctaj echipa in functie de conditie
set serveroutput on;
declare
  cursor c_proiecte IS
    select id_proiect, id_echipa, descriere
    from proiecte
    where length(descriere) < 20
    for update of descriere;

  v_id_echipa echipe.id_echipa%type;
  v_punctaj_curent echipe.punctaj_echipa%type;

begin
  for rec in c_proiecte loop
    v_id_echipa := rec.id_echipa;


    select punctaj_echipa
    into v_punctaj_curent
    from echipe
    where id_echipa = v_id_echipa
    for update;

    update echipe
    set punctaj_echipa = nvl(v_punctaj_curent, 0) - 10
    where id_echipa = v_id_echipa;

    dbms_output.put_line('Penalizare - Proiect ' || rec.id_proiect ||
                         ', echipa ' || v_id_echipa ||
                         ', descriere: "' || rec.descriere || '"');
  end loop;
end;
/

// Functie pentru parcurgerea evaluarile  cu un punctaj sub 85 si actualizam camplu comentariu
set serveroutput on;
declare 
  cursor c_evaluari(p_limita number) is 
    select id_evaluare, punctaj, comentariu 
    from evaluari
    where punctaj < p_limita 
    for update of comentariu;

  r_eval c_evaluari%rowtype;
  v_limita_punctaj number := 85;

begin
  open c_evaluari(v_limita_punctaj);
  loop 
    fetch c_evaluari into r_eval;
    exit when c_evaluari%notfound;

    update evaluari
    set comentariu = r_eval.comentariu || ' Punctaj sub limita calificare '
    where current of c_evaluari;

    dbms_output.put_line('Evaluare ' || r_eval.id_evaluare || ' a fost actualizata.');
  end loop;

  close c_evaluari;
end;
/

//Seminar 6

// Functie cu exceptie custom

set serveroutput on;

declare
  prea_multi_organizatori exception;
  v_nr_organizatori number;
begin
  dbms_output.put_line('Verificarea numarului de organizatori...');
  select count(*)
  into v_nr_organizatori
  from panou
  where rol = 'Organizator';
  dbms_output.put_line('Numarul actual de organizatori este: ' || v_nr_organizatori);
  if v_nr_organizatori > 3 then
    raise prea_multi_organizatori;
  end if;

  dbms_output.put_line('Numarul de organizatori este în limite normale.');

exception
  when prea_multi_organizatori then
    dbms_output.put_line('Exceptie: Exista prea multi utilizatori cu rolul de Organizator ( ' || v_nr_organizatori || ' ). Limita este de 3.');
 
end;
/

//Functie cu sqlcode si sqlerrm

set serveroutput on;

declare
  v_cod_eroare number;
  v_mesaj_eroare varchar2(255);
begin
  dbms_output.put_line('Exercitiu: Incercare de inserare cu eroare in tabela hackathon (afisare eroare)...');
  insert into hackathon (ID_HACKATHON, NUME_HACKATHON, DURATA_ORE, STATUS)
  values (
    200, 
    'Acesta este un nume de hackathon mult, mult prea lung pentru coloana NUME_HACKATHON, care are o limita de 150 de bytes', 
    48,
    'In desfasurare'
  );
  dbms_output.put_line(' Inserare in hackathon reusita. ');
exception
  when others then
     dbms_output.put_line('A aparut o exceptie la operatia pe tabela hackathon.');
    v_cod_eroare := sqlcode;
    v_mesaj_eroare := sqlerrm;
     dbms_output.put_line('Codul erorii: ' || v_cod_eroare);
    dbms_output.put_line('Mesajul erorii: ' || v_mesaj_eroare);
end;
/

// Functie cu exceptie no_data_found si too_many_rows
set serveroutput on;

declare
  v_nume_mentor varchar2(100);
  v_prenume_mentor varchar2(250);
  v_id_mentor number := 9999; -- presupus
begin
  dbms_output.put_line('incercare de regasire mentor cu id: ' || v_id_mentor);

  select nume, prenume
  into v_nume_mentor, v_prenume_mentor
  from mentori
  where id_mentor = v_id_mentor;

  dbms_output.put_line('mentor gasit: ' || v_nume_mentor || ' ' || v_prenume_mentor);

exception
  when no_data_found then
    dbms_output.put_line('eroare: nu s-a gasit niciun mentor cu acest id.');
    dbms_output.put_line('cod sql: ' || sqlcode);
    dbms_output.put_line('mesaj sql: ' || sqlerrm);

  when too_many_rows then
    dbms_output.put_line('eroare: s-au gasit prea multi mentori cu acelasi id.');
    dbms_output.put_line('cod sql: ' || sqlcode);
    dbms_output.put_line('mesaj sql: ' || sqlerrm);
end;
/

//Functie pragma exception

set serveroutput on;
declare 
e_cheie_duplicata exception;
pragma exception_init(e_cheie_duplicata,-000232);
begin 
dbms_output.put_line('Inserare mentor deja existent');
insert into Mentori(id_mentor,nume,prenume,email)
values(1,'David','Andrei','david.andrei@yahoo.com');
dbms_output.put_line('Inserare reusita');
exception 
when e_cheie_duplicata then 
    dbms_output.put_line('Eroare: ID-ul mentorului este deja folosit.');
    dbms_output.put_line('Cod eroare: ' || sqlcode);
    dbms_output.put_line('Mesaj eroare: ' || sqlerrm);
when others then 
    dbms_output.put_line('A aparut o alta eroare: ');
    dbms_output.put_line(SQLERRM);
end;
/

//Seminar 7

//Functie pentru calcul valoare totala premii

create or replace function calculeaza_val_totala_premii
return number 
is 
v_total number;
begin 
select sum(valoare)
into v_total
from Premii;

return v_total;
exception 
when no_data_found then 
dbms_output.put_line('Nu au fost gasite date pentru a realiza operatiunea');
when others then 
dbms_output.put_line('Eroare la calculul sumei');
end;
/

--testare

declare 
total number;
begin 
total:=calculeaza_val_totala_premii;
dbms_output.put_line('Val totala premii este'|| total);
end;
/



//Functie pentru gasirea echipei cu cel mai mare punctaj 

create or replace function calculeaza_id_echipa_punctaj_minim
return Echipe.id_echipa%type
is 
    v_id_echipa Echipe.id_echipa%type;
begin 
select id_echipa into v_id_echipa from Echipe 
order by punctaj asc 
fetch first 1 row only;

return v_id_echipa;

exception 
when no_data_found then 
dbms_output.put_line('Nu au fost gasite echipe');

when others then 
dbms_output.put_line('Eroare la gasirea echipei cu punctaj maxim');

end;
/

--testare 
declare 
v_id_echipa_min Echipe.id_echipa%type;
v_nume_echipa Echipe.nume_echipa%type;
v_punctaj Echipe.punctaj%type;
begin 
v_id_echipa_min :=calculeaza_id_echipa_punctaj_minim;
if v_id_echipa_min is not null then 
select nume_echipa,punctaj into v_nume_echipa,v_punctaj from Echipe where id_echipa=v_id_echipa_min;
dbms_output.put_line('Echipa cu cel mai mare punctaj este '|| v_id_echipa_min||' Nume '|| v_nume_echipa||' Punctaj '||v_punctaj);

else 
dbms_output.put_line('Nu s a identificat nicio echipa din pacate');
end if;
end;/

// Procedura acorda bonus punctaj 
create or replace procedure acorda_punctaj_bonus(p_id_premiu number, pct_val_adaugata number) 
is 
    v_randuri_modificate number;
begin 
    update premii 
    set valoare = valoare + pct_val_adaugata
    where id_premiu = p_id_premiu;

    v_randuri_modificate := sql%rowcount;

    if v_randuri_modificate = 0 then 
        dbms_output.put_line('din pacate nu a fost gasit nimic');
    else
        dbms_output.put_line('valoarea premiului a fost modificata cu ' || pct_val_adaugata);
    end if;
end acorda_punctaj_bonus;
/

--testare 


//Seminar 8

// Creare pachet pentru gestionarea sesiunilor de mentorat

create or replace package p_sesiuni is 
procedure adauga_sesiune(p_id_sesiune Sesiuni_Mentoring.id_sesiune%type,
p_id_mentor Sesiuni_Mentoring.id_mentor%type,
p_id_echipa Sesiuni_Mentoring.id_echipa%type,
p_tema Sesiuni_Mentoring.tema_sesiune%type,
p_data date,
p_durata Sesiuni_Mentoring.durata_minute%type);
function exista_sesiune(p_id_mentor Sesiuni_Mentoring.id_mentor%type,
p_id_echipa Sesiuni_Mentoring.id_echipa%type,
p_data date) return boolean;
end;
/
create or replace package body p_sesiuni is

  procedure adauga_sesiune(
    p_id_sesiune Sesiuni_Mentoring.id_sesiune%type,
    p_id_mentor Sesiuni_Mentoring.id_mentor%type,
    p_id_echipa Sesiuni_Mentoring.id_echipa%type,
    p_tema Sesiuni_Mentoring.tema_sesiune%type,
    p_data date,
    p_durata Sesiuni_Mentoring.durata_minute%type
  ) is
  begin
    insert into Sesiuni_Mentoring (
      id_sesiune, id_mentor, id_echipa, tema_sesiune, data_sesiune, durata_minute
    ) values (
      p_id_sesiune, p_id_mentor, p_id_echipa, p_tema, p_data, p_durata
    );
    
    dbms_output.put_line('Sesiunea a fost adaugata cu succes.');
  end adauga_sesiune;

  function exista_sesiune(
    p_id_mentor Sesiuni_Mentoring.id_mentor%type,
    p_id_echipa Sesiuni_Mentoring.id_echipa%type,
    p_data date
  ) return boolean is
    v_count number;
  begin
    select count(*)
    into v_count
    from Sesiuni_Mentoring
    where id_mentor = p_id_mentor
      and id_echipa = p_id_echipa
      and trunc(data_sesiune) = trunc(p_data);
    
    return v_count > 0;
  end exista_sesiune;

end p_sesiuni;
/



// Creare pachet pentru generare raport Tabela Panou + Proiecte
create or replace package p_raport_proiecte as
  procedure afiseaza_detalii;
  function numara_proiecte(p_id_hackathon number) return number;
end p_raport_proiecte;
/

create or replace package body p_raport_proiecte as 
  procedure afiseaza_detalii is 
    cursor c_proiecte is 
      select id_proiect, nume_proiect, descriere, id_echipa
      from proiecte;

    cursor c_membri(p_echipa_id Proiecte.id_echipa%type) is 
      select nume, prenume, rol 
      from panou 
      where id_echipa = p_echipa_id;

  begin 
    for proiect_r in c_proiecte loop
      dbms_output.put_line('Proiect: ' || proiect_r.nume_proiect);
      dbms_output.put_line('Descriere: ' || proiect_r.descriere);

      for membru_rec in c_membri(proiect_r.id_echipa) loop
        dbms_output.put_line(' - ' || membru_rec.nume || ' ' || membru_rec.prenume ||
                             ' (' || nvl(membru_rec.rol, 'fara rol') || ')');
      end loop;
    end loop;
  end afiseaza_detalii;

  function numara_proiecte(p_id_hackathon number) return number is 
    v_count number;
  begin 
    select count(*)
    into v_count
    from proiecte 
    where id_hackathon = p_id_hackathon;

    return v_count;
  end numara_proiecte;

end p_raport_proiecte;
/


// Creare pachet pentru gestionare jurati 
create or replace package p_gestionare_jurati as 
  procedure adauga_jurat(p_id number, p_nume varchar2, p_prenume varchar2, p_companie varchar2);
  procedure sterge_jurat(p_id number);
  procedure afiseaza_jurati;
end p_gestionare_jurati;
/

create or replace package body p_gestionare_jurati as

  procedure adauga_jurat(
    p_id number, 
    p_nume varchar2, 
    p_prenume varchar2, 
    p_companie varchar2
  ) is
  begin
    insert into juriu(id_jurat, nume, prenume, companie_jurat)
    values(p_id, p_nume, p_prenume, p_companie);
    dbms_output.put_line('Jurat adaugat cu succes.');
  exception
    when others then
      dbms_output.put_line('Eroare la adaugare: ' || sqlerrm);
  end;

  procedure sterge_jurat(p_id number) is
  begin
    delete from juriu where id_jurat = p_id;
    if sql%rowcount = 0 then
      dbms_output.put_line('Niciun jurat nu a fost gasit.');
    else
      dbms_output.put_line('Jurat sters.');
    end if;
  end;

  procedure afiseaza_jurati is 
    cursor c is select * from juriu;
  begin 
    for rec in c loop 
      dbms_output.put_line(rec.id_jurat || ' ' || rec.nume || ' ' || rec.prenume || ' - ' || nvl(rec.companie_jurat, 'Fara companie'));
    end loop;
  end;

end p_gestionare_jurati;
/

// Creare pachet pentru afisare premii 
create or replace package p_premii as 
  procedure afiseaza_premii;
end p_premii;
/

create or replace package body p_premii as 
  procedure afiseaza_premii is 
    cursor c is 
      select id_premiu, nume_premiu, valoare, id_hackathon 
      from premii;
  begin 
    for record in c loop 
      dbms_output.put_line(
        'ID: ' || record.id_premiu || 
        ', Premiu: ' || record.nume_premiu || 
        ', Valoare: ' || record.valoare || 
        ', Hackathon ID: ' || record.id_hackathon
      );
    end loop;
  end afiseaza_premii;
end p_premii;
/

//Seminar 9

//Restrictionare nr mem echipa
create or replace trigger trg_restrictie_nr_mem_echipa
before insert on panou
for each row
declare
    v_nr_mem number;
    max_membri constant number := 5;
begin
    select count(*) into v_nr_mem
    from panou
    where id_echipa = :new.id_echipa;

    if v_nr_mem >= max_membri then
        raise_application_error(
            -34121,
            'Echipa ' || :new.id_echipa || ' a atins numarul maxim de membri (' || max_membri || ').'
        );
    end if;
end;
/

//Previne stergerea unui hackathon activ 
create or replace trigger trg_prevent_del_hackathon
before delete on Hackathon
for each row 
begin 
if :old.status='Activ' then 
raise_application_error(-23412,'Nu se poate sterge un hackathon cu statut "Activ"');
end if;
end;
/

//Scade 5 puncte din punctajul echipei cand se actualizeaza numele proiectului
create or replace trigger trg_rmv_points_project
after update of nume_proiect on Proiecte
for each row 
declare 
v_id_echipa Echipe.id_echipa%type;
begin 
select id_echipa into v_id_echipa 
from Proiecte 
where id_proiect=:new.id_proiect;

update Echipe 
set punctaj_echipa=punctaj_echipa - 5 
where id_echipa=v_id_echipa;
end;
/

//Trigger pentru demonstratie pe tabela Premii cu tabela pentru LOG
create table Premii_Log(msg_operatiune varchar2(500));
create or replace trigger trg_premii_operations_log
after insert or update or delete on Premii
for each row 
begin 
if inserting then insert into Premii_Log(msg_operatiune) values('Un rand a fost inserat in tabela Premii');
elsif updating then insert into Premii_Log(msg_operatiune) values('Un rand a fost actualizat in tabela Premii.');
elsif deleting then insert into Premii_Log(msg_operatiune) values('Un rand a fost sters in tabela Premii.');
end if;
end;
/




