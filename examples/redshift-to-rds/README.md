# Scaling Down a Redshift Cluster to a Simple RDS Instance

< TL;DR

RedShift clusters are great.

Sometimes, it's overkill to run an elastic cluster. 

These are instructions on how to migrate your existing cluster down to a simple RDS instance running postgres in order to save costs without having to stop collecting data or destroying potentially valuable data services.

**BONUS:** I'm including the Terraform code that expresses some example resources so you can see exactly how this works in code.
