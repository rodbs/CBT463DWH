DECLARE @execution_id bigint

EXEC catalog.create_execution
	@folder_name = '70-463',
	@project_name = '14-Troubleshooting',
	@package_name = 'DimCustomer.dtsx',
	@execution_id = @execution_id OUTPUT


EXEC catalog.add_data_tap
	@execution_id = @execution_id,
	@task_package_path = '\Package\Load Staging',
	@dataflow_path_id_string = 'Paths[Customer.OLE DB Source Output]',
	@data_filename = 'CustomerData.csv'

EXEC [catalog].[start_execution] @execution_id

