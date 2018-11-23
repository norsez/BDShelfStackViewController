```
sequenceDiagram 

clientVC ->> Row: client creates rows
Row ->> config: add rows to BDSSV config 
config ->> config: configure scene
config ->> interacter: creates interacter with rows
config ->> presenter: creates presenter
config ->> view: create BDSSV from rows and data



```

```
graph TD


id_start(worker) --> |sends model|id_interacter(interacter)
id_interacter --> |sends model view|id_presenter(presenter)
id_presenter --> |displays model on view|id_view(view)

```