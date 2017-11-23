#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "parson.h"   
#include "type_definitions.h"
#define _CRT_SECURE_NO_WARNINGS

void print_commits_info(const char *username); 
int main()
{
	int i,count=0;
	char temp[100]="";
	char user[150]="";
	char *p_temp;
	p_temp=temp;
    	p_temp=fgets(temp,100,stdin);
	/* if you have space in your string then change space to "%20"*/
	for(i=0;i<100;i++)
	{
		if(temp[i]==' ')
			count++;
	}
	for(i=0;i<100;i++)
	{
		if(temp[i]=='\n')
		{
			temp[i]='\0';
			strcat(user,temp);
			break;
		}
		if(temp[i]==' '&&count>=0)
		{
			temp[i]='\0';
			strcat(user,temp);
			p_temp=&temp[i+1];
			strcpy(temp,p_temp);
			strcat(user,"%20");
			i=0;
			count--;
		}
	}
    	print_commits_info(user);
    	return 0;
}
void print_commits_info(const char *username) {
    	JSON_Value *root_value;
    	JSON_Array *arrays;
    	JSON_Object *rootObjects;
    	JSON_Object *temp;
    	char curl_command[512];
   	double accountId;
	double id;
    	int i;
    	char cleanup_command[256];
    	char output_filename[] = "lol.json";
    	char api_key[] = "RGAPI-e063a979-d914-490f-965e-4ec648df1fe4";
    
	sprintf(curl_command,
        "curl -s \"https://kr.api.riotgames.com/lol/summoner/v3/summoners/by-name/%s/?api_key=%s\">%s",
        username, api_key, output_filename);
    	if(system(curl_command)==-1)
			printf("error");
    	/* parsing json and validating output */
    	root_value = json_parse_file(output_filename);
    	rootObjects = json_value_get_object(root_value);
	/* output*/
    	printf("name : %s\n", json_object_get_string(rootObjects, "name"));
    	printf("level : %f\n", json_object_get_number(rootObjects, "summonerLevel"));
	/* parsing json and validating output */
    	accountId=json_object_get_number(rootObjects,"accountId");
	id=json_object_get_number(rootObjects,"id");
	sprintf(curl_command,"curl -s \"https://kr.api.riotgames.com/lol/league/v3/leagues/by-summoner/%.0lf/?api_key=%s\">%s",
        id,api_key,output_filename);
        if(system(curl_command)==-1)
		printf("error");
        root_value=json_parse_file(output_filename);
        arrays=json_value_get_array(root_value);
        root_value=json_array_get_value(arrays,0);
        rootObjects=json_value_get_object(root_value);
	/*output*/
        printf("tier :%s\n", json_object_get_string(rootObjects,"tier"));
	/* parsing json and validating output */
	sprintf(curl_command,"curl -s \"https://kr.api.riotgames.com/lol/match/v3/matchlists/by-account/%.0lf/?api_key=%s\">%s",
	accountId,api_key,output_filename);
	sprintf(cleanup_command,"rm -f %s", output_filename);
    	if(system(curl_command)==-1)
			printf("error");
    	root_value = json_parse_file(output_filename);
    	rootObjects = json_value_get_object(root_value);
    	/*output*/
    	arrays =json_object_get_array(rootObjects,"matches");
    	printf("%-10.10s %-10.10s %s\n", "platformId", "season", "line");
	for (i = 0; i <(int) json_array_get_count(arrays)&&i<30; i++) 
	{
        temp = json_array_get_object(arrays, i);
        printf("%5s %10.0f %10s\n",
		 json_object_get_string(temp, "platformId"),
		 json_object_get_number(temp, "season"),
                 json_object_get_string(temp, "lane")
		);
    	}

   	/* cleanup code */
   	json_value_free(root_value);
   	if(system(cleanup_command)==-1)
			printf("error");
}
