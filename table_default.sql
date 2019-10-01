--create table 
create table humaster.tb_feriado_local(
  dt_feriado             date not null,
  cd_feriado             number(2) not null,
  cd_empresa_plano       number(2) not null

);

--comentário de tabela 
comment on table humaster.tb_feriado_local is 'TABELA PARA LISTAR FERIADOS REGIONAIS';

--comentários de colunas
comment on column humaster.tb_feriado_local.dt_feriado is 'Data do feriado regional a ser colocada anualmente';
comment on column humaster.tb_feriado_local.cd_feriado is 'Tipo do feriado cadastrado na tabela tb_feriado';
comment on column humaster.tb_feriado_local.cd_empresa_plano is 'Campo usado SOMENTE para IPM e SASSEPE - chave estrangeira tb_filial';


-- create/recreate indexes 
create index humaster.ix_tb_feriado_local on humaster.tb_feriado_local (dt_feriado);

-- create/recreate primary, unique and foreign key constraints 
alter table humaster.tb_feriado_local add constraint cp_tb_feriado_local primary key (dt_feriado)
  using index humaster.ix_tb_feriado_local;

--criação de synonym  
create or replace public synonym tb_feriado_local for humaster.tb_feriado_local; 
 
-- grant/revoke object privileges 
grant select, insert, update, delete on humaster.tb_feriado_local to rl_administracao4, rl_plano_saude4;



alter table TB_FERIADO_LOCAL
  add constraint CT_FERIADO_LOCAL1 foreign key (CD_FERIADO)
  references TB_FERIADO (CD_FERIADO);
  
alter table TB_FERIADO_LOCAL
  add constraint CT_FERIADO_LOCAL2 foreign key (CD_EMPRESA_PLANO)
  references TB_FILIAL (CD_EMPRESA_PLANO);  
-- Create/Recreate check constraints 
alter table TB_FERIADO_LOCAL
  add constraint CH_DATA_FERIADO
  check (dt_feriado>to_date('01011870','ddmmyyyy'));
