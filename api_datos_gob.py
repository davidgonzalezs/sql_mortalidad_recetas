import requests
URL_BASE = "https://datos.gob.es/apidata/"
output_file = r'C:\Users\David\Desktop\prueba.csv'

def get_dato(url_dato):
    url = f"{URL_BASE}{url_dato}"
    print(url)
    response = requests.get(url, headers={
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36",
    'Accept': 'text/csv'})

    if(response.status_code == 200):
        return response.json()
    else:
        print("Error: Dato no encontrado.")
        return None


def descarga_csv(url_descarga):
    response = requests.get(url_descarga)
    if response.status_code == 200:
        with open(output_file, 'wb') as f:
            f.write(response.content)
        print(f"CSV guardado como: {output_file}")
    else:
        print(f"Error al descargar el archivo: {response.status_code}")    


if __name__ == "__main__":
    print("Consultor Datos Gob ...")
    url_dato = "catalog/dataset/a09002970-recetas-facturadas-al-servei-catala-de-la-salut"
    
    if(datos:= get_dato(url_dato)):
        for i in datos['result']['items'][0]['distribution']:
            url_descarga = i['accessURL']
            formato = i['format']['value']
            print(url_descarga)
            print(formato)
            if('csv' in formato):
                descarga_csv(url_descarga)
            print('---------')
       
    else:
        print("Estás seguro de que ese nombre existe?")