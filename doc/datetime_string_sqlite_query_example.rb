FieldAssociation.where(target: item).where("datetime(substr(value, 1, 19)) = datetime(?)", DateTime.new(2023,04,3,9,41,57).utc.strftime("%Y-%m-%d %H:%M:%S"))


 Item.all.joins(field_associations: :field).where({ field_associations: { value: "1", fields: { identifier: "quantity" } } }).to_sql
=> "SELECT \"items\".* FROM \"items\" INNER JOIN \"field_associations\" ON \"field_associations\".\"target_type\" = 'Item' AND \"field_associations\".\"target_id\" = \"items\".\"id\" INNER JOIN \"fields\" ON \"fields\".\"id\" = \"field_associations\".\"field_id\" WHERE \"field_associations\".\"value\" = '1' AND \"fields\".\"identifier\" = 'quantity'"
>> Item.all.joins(field_associations: :field).where({ field_associations: { value: "1", fields: { identifier: "quantity" } } })
=>


FieldAssociation.joins(:field).where(
  "(datetime(substr(value, 1, 19)) > datetime(:date) AND datetime(substr(value, 1, 19))) < date('now') AND fields.identifier = :identifier",
  date: 5.days.ago.strftime("%Y-%m-%d %H:%M:%S"), identifier: "produced_date"
).to_sql


 FieldAssociation.joins(:field).where("(datetime(substr(value, 1, 19)) > datetime(:date) AND datetime(substr(value, 1, 19))) < date('now') AND fields.identifier = :identifier", date: 5.days.ago.strftime
("%Y-%m-%d %H:%M:%S"), identifier: "produced_date")

Item.all
  .joins(field_associations: :field)
  .where(
    "(datetime(substr(value, 1, 19)) > datetime(:date) AND datetime(substr(value, 1, 19))) < date('now') AND fields.identifier = :identifier",
    date: 3.days.ago.strftime("%Y-%m-%d %H:%M:%S"), identifier: "produced_date"
  )


Item.all.joins(field_associations: :field).where("datetime(substr(value, 1, 19)) > datetime(:date) AND fields.identifier = :identifier", date: 3.days.ago.strftime("%Y-%m-%d %H:%M:%S"), identifier: "pro
duced_date")
