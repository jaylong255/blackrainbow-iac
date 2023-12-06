 resource "aws_vpc" "main" {
   cidr_block = "10.0.0.0/16"

   tags = {
     Name = "${local.project_name}-${local.environment}-vpc"
     Environment = local.environment
     Project = local.project_name
   }
 }

resource "aws_subnet" "database" {
    vpc_id     = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"

    tags = {
     Name = "${local.project_name}-${local.environment}-db-subnet"
     Environment = local.environment
     Project = local.project_name
    }
}

resource "aws_eip" "database" {
    vpc = true
}

resource "aws_nat_gateway" "database" {
    allocation_id = aws_eip.database.id
    subnet_id     = aws_subnet.database.id

    tags = {
        Name = "${local.project_name}-${local.environment}-db-nat-gateway"
        Environment = local.environment
        Project = local.project_name
    }
}

resource "aws_route_table" "database" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = aws_subnet.database.cidr_block
        nat_gateway_id = aws_nat_gateway.database.id
    }
}

resource "aws_route_table_association" "database" {
    subnet_id      = aws_subnet.database.id
    route_table_id = aws_route_table.database.id
}

resource "aws_subnet" "utility" {
    vpc_id     = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"

    tags = {
     Name = "${local.project_name}-${local.environment}-utility-subnet"
     Environment = local.environment
     Project = local.project_name
    }
}

resource "aws_eip" "utility" {
    vpc = true
}

# internet gateway for utility subnet
resource "aws_internet_gateway" "utility" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${local.project_name}-${local.environment}-utility-igw"
        Environment = local.environment
        Project = local.project_name
    }
}

resource "aws_route_table" "utility" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = aws_subnet.utility.cidr_block
        gateway_id = aws_internet_gateway.utility.id
    }
}

resource "aws_route_table_association" "utility" {
    subnet_id      = aws_subnet.utility.id
    route_table_id = aws_route_table.utility.id
}