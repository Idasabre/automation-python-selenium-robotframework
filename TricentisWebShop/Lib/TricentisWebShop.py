import csv
from openpyxl import Workbook
from openpyxl.drawing.image import Image as ExcelImage
from datetime import datetime
import pyautogui
from PIL import Image as PILImage
from tkinter import Image
import os
import shutil


def clear_folder(folder_path):
    """
    Clears all files and subdirectories from the specified folder.

    Parameters:
    folder_path (str): The path to the folder to clear.
    """
    try:
        for filename in os.listdir(folder_path):
            file_path = os.path.join(folder_path, filename)
            if os.path.isfile(file_path) or os.path.islink(file_path):
                # Remove files or symbolic links
                os.remove(file_path)
            elif os.path.isdir(file_path):
                # Recursively delete directories and their contents
                shutil.rmtree(file_path)
        print(f"Folder cleared: {folder_path}")
    except Exception as e:
        print(f"An error occurred while clearing the folder: {e}")
        
        
def get_user_data(file_path):
    """
    Read data from csv file
    """

    login_details = []
    with open(file_path, mode='r') as file:
            csv_list = csv.reader(file)
            next(csv_list)
            for row in csv_list:
                login_details.append({"gender": row[0], "firstname": row[1], "lastname": row[2], "email": row[3], "password": row[4]})
    return login_details


def gen_excel_file(folder_path, file_name, module_name):
    """
    Adds all images from the folder to an Excel file with numbering and a timestamped sheet name for reporting.
    
    Parameters:
    folder_path (str): The base folder where the screenshots are stored.
    file_name (str): The path to save the Excel file.
    module_name (str): The module name used to create a subfolder and to name the Excel sheet.
    """

    # Create a new workbook and select the active sheet
    wb = Workbook()
    ws = wb.active

    # Create a timestamp for the sheet title
    timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    
    # Set the sheet title with the module name and timestamp
    ws.title = f"{module_name}_{timestamp}"

    # Set headers
    ws.cell(row=1, column=1, value="No.")
    ws.cell(row=1, column=2, value="Screenshot")

    # Retrieve filenames and their creation times
    files_with_time = []
    for filename in os.listdir(folder_path):
        if filename.lower().endswith((".png", ".jpg", ".jpeg")):
            file_path = os.path.join(folder_path, filename)
            creation_time = os.path.getctime(file_path)
            files_with_time.append((filename, creation_time))

    # Sort filenames based on creation time
    files_with_time.sort(key=lambda x: x[1])  # Sort by creation time

    # Initialize row number and image number
    row_number = 2  # Start from the second row (first row is header)
    image_number = 1

    for filename, _ in files_with_time:
        image_path = os.path.join(folder_path, filename)

        # Calculate the row number where the image will be placed
        img_row_number = row_number + 1

        # Add image number in the first column
        ws.cell(row=row_number, column=1, value=image_number)
        
        # Add image filename without extension in the cell above the image
        filename_no_ext = os.path.splitext(filename)[0]  # Remove file extension
        ws.cell(row=row_number, column=2, value=filename_no_ext)

        # Open the image to get its size
        with PILImage.open(image_path) as im:
            # Keep original image dimensions
            orig_width, orig_height = im.size

        # Add image to worksheet
        img = ExcelImage(image_path)
        cell_address = f'B{img_row_number}'
        ws.add_image(img, cell_address)

        # Adjust column width to fit the image
        col_width = orig_width / 7  # Approximate conversion factor
        ws.column_dimensions['B'].width = max(ws.column_dimensions['B'].width, col_width)

        # Adjust row height to fit the image
        # Convert image height (in pixels) to row height (in points)
        row_height = orig_height * 0.75  # Conversion factor: 1 pixel ≈ 0.75 points
        current_row_height = ws.row_dimensions[img_row_number].height
        if current_row_height is None:
            current_row_height = 15  # Set a default height if None
        ws.row_dimensions[img_row_number].height = max(current_row_height, row_height)

        # Increment for the next row (skip an additional row for spacing)
        row_number += 3  # 2 rows for spacing + 1 row for the image
        image_number += 1

    try:
        # Save the workbook
        wb.save(file_name)
        print(f"Excel file saved as {file_name}")
    except PermissionError as e:
        print(f"Permission Error: {e}")
    except Exception as e:
        print(f"An error occurred: {e}")


def capture_screenshot(file_path):
    try:
        # Create the directory if it doesn't exist
        os.makedirs(os.path.dirname(file_path), exist_ok=True)

        # Take screenshot using pyautogui
        screenshot = pyautogui.screenshot()

        # Save the screenshot to the specified path
        screenshot.save(file_path)
        print(f"Screenshot saved at {file_path}")

    except Exception as e:
        print(f"An error occurred: {e}")


def get_webshop_items(file_path):
    """
    Read data from csv file
    """

    items = []
    with open(file_path, mode='r') as file:
            csv_list = csv.reader(file)
            next(csv_list)
            for row in csv_list:
                items.append({"category": row[0], "sub-category": row[1], "items": row[2]})
    return items

def convert_to_float(item):
    num = float(item)
    return num